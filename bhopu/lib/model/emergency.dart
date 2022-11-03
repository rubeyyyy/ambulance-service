
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

const String google_api_key = "AIzaSyASWWy9gVLxU-J4sxZavRQ_nsFqFDVMDI8";

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();
String googleApikey = "AIzaSyASWWy9gVLxU-J4sxZavRQ_nsFqFDVMDI8";
  GoogleMapController? mapController;
  static const LatLng sourceLocation = LatLng(28.394857, 84.124008);
  static const LatLng destination = LatLng(28.237987, 83.995588);
  static const double _defaultLat = 8.85577417427599;
  static const double _defaultLng = 38.85577417427599;
  static const CameraPosition _defaultLocation = CameraPosition(target: LatLng(_defaultLat,_defaultLng),zoom: 15);

  loc.LocationData? currentLocation;

  void getCurrentLocation() {
    loc.Location location = loc.Location();

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
  String location = "Search Location"; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
             title: Text("Place Search Autocomplete Google Map"),
             backgroundColor: Colors.deepPurpleAccent,
          ),
      // body: GoogleMap(
      //   initialCameraPosition:CameraPosition (
      //             target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      //             zoom: 13.5,
      //   ),
      //   markers: {
      //     Marker(
      //           markerId: const MarkerId("currentLocation"),
      //           position: LatLng(
      //             currentLocation!.latitude!, currentLocation!.longitude!),
      //           ),
      //     // const Marker(
      //     //   markerId: MarkerId("source"),
      //     //   position: sourceLocation,
      //     // ),
      //     // const Marker(
      //     //   markerId: MarkerId("destination"),
      //     //   position: destination,
      //     // ),
      //   },
      //   onMapCreated: (mapController) {
      //     _controller.complete(mapController);
      //   },
      // ),
      // AppBar
        body: Stack(
          children: <Widget>[
            currentLocation == null ? const Center(child: Text("Loading")) :
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
            ), 
            Positioned(  //search input bar
               top:10,
               child: InkWell(
                 onTap: () async {
                  var place = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: googleApikey,
                          mode: Mode.overlay,
                          types: [],
                          strictbounds: false,
                          components: [Component(Component.country, 'np')],
                                      //google_map_webservice package
                          onError: (err){
                             print(err);
                          }
                      );

                   if(place != null){
                        setState(() {
                          location = place.description.toString();
                        });

                       //form google_maps_webservice package
                       final plist = GoogleMapsPlaces(apiKey:googleApikey,
                              apiHeaders: await GoogleApiHeaders().getHeaders(),
                                        //from google_api_headers package
                        );
                        String placeid = place.placeId ?? "0";
                        final detail = await plist.getDetailsByPlaceId(placeid);
                        final geometry = detail.result.geometry!;
                        final lat = geometry.location.lat;
                        final lang = geometry.location.lng;
                        var newlatlang = LatLng(lat, lang);
                        

                        //move map camera to selected place with animation
                        mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
                   }
                 },
                 child:Padding(
                   padding: EdgeInsets.all(15),
                    child: Card(
                       child: Container(
                         padding: EdgeInsets.all(0),
                         width: MediaQuery.of(context).size.width - 40,
                         child: ListTile(
                            title:Text(location, style: TextStyle(fontSize: 18),),
                            trailing: Icon(Icons.search),
                            dense: true,
                         )
                       ),
                    ),
                 )
               )
             )

// Container
          ], // <Widget>[]]
        ),
    );
  }
}