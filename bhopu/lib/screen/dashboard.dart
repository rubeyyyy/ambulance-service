import 'package:bhopu/model/order_tracking_page.dart';
import 'package:bhopu/screen/ambulanceUser.dart';
import 'package:bhopu/screen/booking.dart';
import 'package:bhopu/screen/cancelBooking.dart';
import 'package:bhopu/screen/navbar.dart';
import 'package:bhopu/screen/userMap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bhopu'),
        backgroundColor: Color.fromARGB(255, 113, 174, 202),
      ),
      drawer: NavBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 250,
            width: 370,
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.all(20.0),
            color: Color.fromARGB(188, 131, 186, 231),
            child: Stack(
              children: [
                Container(
                    child: Text(
                  'Emergency Service',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Montserrat',
                      color: Colors.white),
                )),
                Positioned(
                  bottom: 0,
                  child: TextButton(
                    child: Text(
                      "Call Now",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 214, 126, 115),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => userMap()));
                    },
                  ),
                ),
                Positioned(
                  bottom: 1,
                  right: 0,
                  child: ElevatedButton(
                    onPressed: callNumber,
                    child: Text(
                      'SOS',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 5, 5),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      fixedSize: const Size(85, 85),
                      shape: const CircleBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 250,
            width: 370,
            padding: EdgeInsets.all(15.0),
            margin: EdgeInsets.all(20.0),
            color: Color.fromARGB(187, 153, 196, 231),
            child: Stack(
              children: [
                Container(
                  child: Text(
                    'Book an Ambulance',
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Montserrat',
                        color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: TextButton(
                    child: Text(
                      "Book now",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 243, 146, 133),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ambulanceUser()));
                    },
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: TextButton(
                    child: Text(
                      "Cancel Booking",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 243, 146, 133),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CancelBooking()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

callNumber() async {
  const number = '9843815802';
  bool? call = await FlutterPhoneDirectCaller.callNumber(number);
}
