import 'package:bhopu/screen/booking.dart';
import 'package:bhopu/screen/cancelBooking.dart';

import 'package:bhopu/screen/navbar.dart';
import 'package:bhopu/model/order_tracking_page.dart';
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

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
      body: SafeArea(
        child: Column(
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
                        "Cal now",
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
                                builder: (context) => OrderTrackingPage()));
                      },
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => booking()));
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => cancelBooking()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
