import 'package:bhopu/main.dart';
import 'package:bhopu/screen/serviceproRegister.dart';
import 'package:bhopu/screen/registerUser.dart';
import 'package:flutter/material.dart';

class registerChoice extends StatefulWidget {
  const registerChoice({Key? key}) : super(key: key);

  @override
  State<registerChoice> createState() => _registerChoiceState();
}

class _registerChoiceState extends State<registerChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: Text(
                  'Register As',
                  style: TextStyle(fontSize: 55, color: Color.fromARGB(255, 30, 140, 190)),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => registerUser()));
                  },
                  child: Text(
                    'User',
                    style: TextStyle(fontSize: 85, color: Colors.white),
                  )),
              SizedBox(
                height: 70,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => servieproRegister()));
                  },
                  child: Text(
                    'Service \nProvider',
                    style: TextStyle(fontSize: 70, color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
