import 'package:bhopu/screen/navbar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// import 'package:custom_switch/custom_switch.dart';

class serviceDashboard extends StatefulWidget {
  const serviceDashboard({ Key? key }) : super(key: key);


  @override
  State<serviceDashboard> createState() => _serviceDashboardState();
}

class _serviceDashboardState extends State<serviceDashboard> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(28.394857, 84.124008);
  static const LatLng destination = LatLng(28.237987, 83.995588);
  static const double _defaultLat = 8.85577417427599;
  static const double _defaultLng = 38.85577417427599;
  static const CameraPosition _defaultLocation = CameraPosition(target: LatLng(_defaultLat,_defaultLng),zoom: 15);
  LocationData? currentLocation;
  void getCurrentLocation() {
    Location location = Location();

    location.getLocation().then(
          (location){
        currentLocation = location;
      },
    );
    setState(() {

    });
  }
  final Set<Marker> _markers= {};
  void _addMarker() {
    setState((){
      _markers.add(
        Marker(
          markerId: MarkerId('defaultLocation'),
          position: _defaultLocation.target,
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: const InfoWindow(
            title: "PLACE NAME",
            snippet: "RATINGS",
          ),
        ),
      );
    });
  }
  @override
  void initState() {
    getCurrentLocation();
  }
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(title: Text('Bhopu'),
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

                          Text('Availability',
                            style: TextStyle(fontSize: 25,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                                color: Colors.black),),

                          Text(
                            'Please turn off availability while you are engaged',
                            style: TextStyle(fontSize: 12,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Montserrat',
                                color: Colors.black),),

                        ],
                      ),

                      Container(

                          child: Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                              });
                            },
                            activeTrackColor: Color.fromARGB(
                                255, 231, 187, 170),
                            activeColor: Color.fromARGB(232, 185, 81, 74),

                          )
                      ),

                    ]
                ),
                SizedBox(
                  height: 30,
                ),
                Text("Your location", style: TextStyle(fontSize: 25,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                    color: Colors.black),),


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
                    child: currentLocation == null ? const Center(child: Text("Loading")) :
                    GoogleMap(
                        initialCameraPosition:CameraPosition (
                          target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                          zoom: 13.5,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId("currentLocation"),
                            position: LatLng(
                                currentLocation!.latitude!, currentLocation!.longitude!),
                          )
                        }),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                Container(
                  padding: const EdgeInsets.only(top: 24, right: 12),
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      FloatingActionButton(onPressed: _addMarker,backgroundColor: Colors.deepOrangeAccent,
                        child: const Icon(Icons.add_location,size :36.0),
                      )
                    ],
                  ), // Column
                ), //
                SizedBox(
                  height: 10,
                ),
                Text("You're Booked for:", style: TextStyle(fontSize: 25,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                    color: Colors.black),),

                Container(
                  width: 400,
                  height: 170,
                  padding: new EdgeInsets.all(5.0),
                  child: Card(
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
                              Text(
                                  'Name of Patient:',
                                  style: TextStyle(fontSize: 17.0)
                              ),
                              Text(
                                  'Date:',
                                  style: TextStyle(fontSize: 17.0)
                              ),
                              Text(
                                  'Time:',
                                  style: TextStyle(fontSize: 17.0)
                              ),
                              Text(
                                  'Phone Number:',
                                  style: TextStyle(fontSize: 17.0)
                              ),
                              Text(
                                  'Location From:',
                                  style: TextStyle(fontSize: 17.0)
                              ),
                              Text(
                                  'Location To:',
                                  style: TextStyle(fontSize: 17.0)
                              ),


                            ]
                        ),
                      )
                  ),


                ),


              ]
          ),
        ),
      ),

    );
  }
}