import 'package:bhopu/screen/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
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

// import 'package:custom_switch/custom_switch.dart';

class serviceDashboard extends StatefulWidget {
  const serviceDashboard({Key? key}) : super(key: key);

  @override
  State<serviceDashboard> createState() => _serviceDashboardState();
}
const kGoogleApiKey = 'AIzaSyD5Z5YTEO32vVbfauAVGOwyXcvtjLajIgY';
class _serviceDashboardState extends State<serviceDashboard> {
  FirebaseAuth _authe = FirebaseAuth.instance;
  late bool Avai = false;

  FirebaseAuth _auth=FirebaseAuth.instance;
  final CollectionReference _referenceList =
      FirebaseFirestore.instance.collection('service providers');
      late Stream<QuerySnapshot> _streamList;

final CollectionReference _referenceListe =
      FirebaseFirestore.instance.collection('service providers').doc(FirebaseAuth.instance.currentUser!.uid).collection('Notification');
      late Stream<QuerySnapshot> _streamListe;

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
     _streamListe = _referenceListe.snapshots();
    getMarkerData();
    activateListner();
    super.initState();
  }
 bool isAfterToday(Timestamp timestamp) {
    return DateTime.now().toUtc().isBefore(
        DateTime.fromMillisecondsSinceEpoch(
            timestamp.millisecondsSinceEpoch,
            isUtc: false,
        ).toUtc(),
    );
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

  bool getAva() {
    FirebaseFirestore.instance
        .collection('service providers')
        .doc(_authe.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        Avai = value.data()!['availabilty'];
      }
    });
    return Avai;
  }

  

  //bool isSwitched = getAva();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bhopu'),
        backgroundColor: Color.fromARGB(255, 113, 174, 202),
      ),
      drawer: NavBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Availability',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                                color: Colors.black),
                          ),
                          Text(
                            'Please turn off availability while you are engaged',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Montserrat',
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                          child: Switch(
                        value: getAva(),
                        onChanged: (value) {
                          setState(() {
                            if (Avai == false) {
                              setState(() {
                                Avai = true;
                                FirebaseFirestore.instance
                                    .collection('service providers')
                                    .doc(_authe.currentUser!.uid)
                                    .update({'availability': 'true'});
                                // textValue = 'Switch Button is ON';
                              });
                              // print('Switch Button is ON');
                            } else {
                              setState(() {
                                Avai = false;
                                FirebaseFirestore.instance
                                    .collection('service providers')
                                    .doc(_authe.currentUser!.uid)
                                    .update({'availability': 'false'});
                                //textValue = 'Switch Button is OFF';
                              });
                              //print('Switch Button is OFF');
                            }

                            //isSwitched = value;
                          });
                        },
                        activeTrackColor: Color.fromARGB(255, 231, 187, 170),
                        activeColor: Color.fromARGB(232, 185, 81, 74),
                      )),
                    ]),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Your location",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                      color: Colors.black),
                ),

                Container(
                  width: 400,
                  height: 400,
                  padding: new EdgeInsets.all(5.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Color.fromARGB(255, 241, 223, 222),
                    elevation: 10,
                    child:  GoogleMap(
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
                ),
                SizedBox(
                  height: 30,
                ),

              
                SizedBox(
                  height: 10,
                ),
                Text(
                  "You're Booked for:",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                      color: Colors.black),
                ),

                Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Color.fromARGB(255, 241, 223, 222),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              StreamBuilder<QuerySnapshot>(
                stream: _streamListe,
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
                          return isAfterToday(document['Date'])?Card(
                              // child: Container(
                              //   child: Text((document['name'])),
                              //   height: 20,
                              // ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Color.fromARGB(255, 238, 230, 230),
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Patient Name: ' + (document['PatientName']),
                                          style: TextStyle(fontSize: 15.0)),
                                      // Text('Phone No: ' + (document['PhoneNo']),
                                      //     style: TextStyle(fontSize: 15.0)),
                                      // Text(
                                      //     'Age.: ' +
                                      //         (document['Age']),
                                      //     style: TextStyle(fontSize: 15.0)),
                                      Text(
                                          'location from: ' +
                                              (document['AddFrom']),
                                          style: TextStyle(fontSize: 15.0)),
                                          Text(
                                          'location To: ' +
                                              (document['AddTo']),
                                          style: TextStyle(fontSize: 15.0)),
                                           Text(
                                          'Date: ' +
                                              (
                                                document['Date'].toDate().toString()
                                                //DateTime.fromMillisecondsSinceEpoch(document['Date']).toString()
                                                ),
                                          style: TextStyle(fontSize: 15.0)),
                                           Text(
                                          'Time: ' +
                                              (document['Time']),
                                          style: TextStyle(fontSize: 15.0)),
                                    ]),
                              )): Container();
                        });
                  }

                  return const Center(child: CircularProgressIndicator());
                }),

                            ]
                        ),
                      )
                  ),
                ],),
              ),
        ),
      );
   
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
