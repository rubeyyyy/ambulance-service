import 'package:bhopu/screen/booking.dart';
import 'package:bhopu/screen/cancelBooking.dart';
import 'package:bhopu/screen/emergency.dart';
import 'package:bhopu/screen/navbar.dart';
import 'package:flutter/material.dart';

class dashboard extends StatefulWidget {
  const dashboard({ Key? key }) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();

}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Center(
                  child: Text(
                'RUBSSS'
                '',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
