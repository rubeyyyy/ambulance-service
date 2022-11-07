import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:bhopu/screen/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class userMap extends StatefulWidget {
  const userMap({Key? key}) : super(key: key);

  @override
  State<userMap> createState() => _userMapState();
  
}
const kGoogleApiKey = 'AIzaSyD5Z5YTEO32vVbfauAVGOwyXcvtjLajIgY';
String availabilityStats = "";
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _userMapState extends State<userMap> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  final CollectionReference _referenceList =
      FirebaseFirestore.instance.collection('service providers');
      late Stream<QuerySnapshot> _streamList;
  //list of markers
  final Set<Marker> markers = new Set();
  Set<Marker> markersList = {};
  double Lat = 0;
  double Long = 0;
  late GoogleMapController googleMapController;
  final Mode _mode = Mode.overlay;
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(27.6720636, 85.3402312), zoom: 100);

  //Set<Marker> markers = {};

  @override
  void initState() {
     _streamList = _referenceList.snapshots();
    getMarkerData();
    activateListner();
    super.initState();
  }

  void activateListner() async {
    Position position = await _determinePosition();
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 14)));
    //markersList.clear();
    //markerss[0]=marker;
    markers.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: "Update Venue Location",
        ))
    );

    setState(() {});
  }
  Map<MarkerId, Marker> markerss =<MarkerId,Marker> {};
  void initMarker(specify, specifyID) async {
    var markerIdVal = specifyID;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(markerId: markerId,
        position: LatLng(specify['Latitude'], specify['Longitude']),
        infoWindow: InfoWindow(title: specify['Name'],)
    );
    setState(() {
      markerss[markerId]=marker;
    });

  }
  Future getMarkerData() async {
    FirebaseFirestore.instance.collection("service providers").get().then((value){
      if(value.docs.isNotEmpty){
        for(int i=0;i<value.docs.length;i++){
          print("PRINTING DATA");
          initMarker(value.docs[i].data(), value.docs[i].id);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                 SizedBox(
                  width: 450,
                  height: 50,
                   child: ElevatedButton(
                    
                        onPressed: _handlePressButton,
                        child: const Text("Search Places",),
                        style: ButtonStyle(
                          
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Color.fromARGB(255, 211, 242, 255)))),
                 ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    
                    child: GoogleMap(
                      initialCameraPosition: initialCameraPosition,
                      markers: Set<Marker>.of(markerss.values),
                      mapType: MapType.normal,
                      onMapCreated: (GoogleMapController controller) {
                        googleMapController = controller;
                      },
                      gestureRecognizers: Set()
                       ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                    ),
                  ),
              
               SizedBox(
                      height: 30,
                    ),
        
                 
                   
             Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Color.fromARGB(255, 241, 223, 222),
                            // elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    StreamBuilder<QuerySnapshot>(
                      stream: _streamList,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        }
          
                        if (snapshot.connectionState == ConnectionState.active) {
                          QuerySnapshot querySnapshot = snapshot.data;
                          List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
                              querySnapshot.docs;
          
                          return ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemCount: listQueryDocumentSnapshot.length,
                              itemBuilder: (context, index) {
                                QueryDocumentSnapshot document =
                                    listQueryDocumentSnapshot[index];
                                    if(document['availability']=='true')
                                availabilityStats="Available";
                              else
                                availabilityStats="Unavailable";
                                return Card(
                                    // child: Container(
                                    //   child: Text((document['name'])),
                                    //   height: 20,
                                    // ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    color: Color.fromARGB(255, 238, 230, 230),
                                    elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text('Name: ' + (document['name']),
                                                    style: TextStyle(fontSize: 15.0)),
                                                Text('Availability Status: ' + (availabilityStats),
                                                    style: TextStyle(fontSize: 15.0)),
                                                
                                              ]),
                                              ElevatedButton(
                                          child: Text(
                                            "Call",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            callNumber() async {
                                              print("CALL NUMBER CALLED     "+document['ph_num']);
                                              var number = document['ph_num'];
                                              bool? call = await FlutterPhoneDirectCaller.callNumber(number);
                                            }
                                            callNumber();
      
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color.fromARGB(
                                                          255, 30, 140, 190))),
                                        ),
                                        ],
                                        
                                      ),
                                    ));
                              });
                        }
          
                        return const Center(child: CircularProgressIndicator());
                      }),
          
                                  ]
                              ),
                            )
                        ),
          
        
              // 
          ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // final uid = extractData().getUserUID();
          final docUser = FirebaseFirestore.instance.collection('service providers').doc(_auth.currentUser!.uid);
          // docUser.update(
          //     {
          //
          //     }
          // );
          Position position = await _determinePosition();
          Lat=position.latitude;
          Long=position.longitude;
          docUser.update(
              {
                "Latitude":Lat,
                "Longitude":Long
              }
          );
          // googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          //     CameraPosition(
          //         target: LatLng(position.latitude, position.longitude),
          //         zoom: 14)));
          // //markersList.clear();
          // markersList.add(Marker(
          //     markerId: const MarkerId('currentLocation'),
          //     position: LatLng(position.latitude, position.longitude),
          //     infoWindow: const InfoWindow(
          //       title: "Update Venue Location",
          //     )
          // ));

          setState(() {});
        },
        label: const Text("Update Venue Location"),
        icon: const Icon(Icons.location_history),
      ),

    );
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
        components: [Component(Component.country, "npl")]);

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   elevation: 0,
    //   behavior: SnackBarBehavior.floating,
    //   backgroundColor: Colors.transparent,
    //   content: AwesomeSnackbarContent(
    //     title: 'Message',
    //     message: response.errorMessage!,
    //     contentType: ContentType.failure,
    //   ),
    // ));

    // homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    markersList.clear();
    markersList.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  } //
}

