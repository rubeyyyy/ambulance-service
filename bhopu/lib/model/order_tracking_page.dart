import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

const String google_api_key = "AIzaSyASWWy9gVLxU-J4sxZavRQ_nsFqFDVMDI8";

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);


  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: sourceLocation,
          zoom: 15.5,
        ),
        markers: {
          const Marker(
            markerId: MarkerId("source"),
            position: sourceLocation,
          ),
          const Marker(
            markerId: MarkerId("destination"),
            position: destination,
          ),
        },
        onMapCreated: (mapController) {
          _controller.complete(mapController);
        },
      ),
    );
  }
}
