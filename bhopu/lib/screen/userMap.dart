
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
class userMap extends StatefulWidget {
  const userMap({Key? key}) : super(key: key);

  @override
  State<userMap> createState() => _userMapState();
}
const kGoogleApiKey = 'AIzaSyASWWy9gVLxU-J4sxZavRQ_nsFqFDVMDI8';
final homeScaffoldKey = GlobalKey<ScaffoldState>();
class _userMapState extends State<userMap> {

  //list of markers
  final Set<Marker> markers = new Set();
  Set<Marker> markersList = {};
  double Lat = 0;
  double Long = 0;
  late GoogleMapController googleMapController;
  final Mode _mode = Mode.overlay;
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(27.6720636, 85.3402312), zoom: 100);
  FirebaseAuth _auth=FirebaseAuth.instance;
  //Set<Marker> markers = {};

  @override
  void initState() {
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
      appBar: AppBar(
        title: const Text("Google Search Places"),
      ),

      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: GoogleMap(
              initialCameraPosition: initialCameraPosition,
              markers: Set<Marker>.of(markerss.values),
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
            ),
          ),
          Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('service providers').snapshots(),
              builder: (context, snapshots) {
                return (snapshots.connectionState == ConnectionState.waiting)
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(

                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                      as Map<String, dynamic>;
                      print("data printing");
                      print(data);
                      return GestureDetector(
                          onTap: () {
                            print("Tapped ");


                            // add call button
                          },

                          //radius vairacha somehow
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    data['name'].toString(),
                                    style: TextStyle(
                                        fontFamily: 'Comfortaa',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    });
              },
            ),
          ),

          ElevatedButton(
              onPressed: _handlePressButton,
              child: const Text("Search Places")),

        ],
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

