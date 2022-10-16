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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/image/5.jpg'), fit: BoxFit.cover
        )
      ),
      child:  Scaffold(
      backgroundColor: Colors.transparent,

      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 175,
              ),
              Center(
                child: Text(
                  'Register As',
                  style: TextStyle(fontSize: 35,fontWeight: FontWeight.w500, color: Color.fromARGB(255, 113, 174, 202)),
                ),
              ),
              SizedBox(
                height: 35,
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
                    style: TextStyle(fontSize: 45,fontWeight: FontWeight.w300, fontFamily: 'Montserrat', color: Colors.white),
                  ),
                    style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 214, 126, 115) ,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold)),
                  ),
              SizedBox(
                height: 35,
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
                    style: TextStyle(fontSize: 40,fontWeight: FontWeight.w300, fontFamily: 'Montserrat', color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(primary: Color.fromARGB(188, 131, 186, 231),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold)),

                  )
                  
            ],
          ),
        ),
      ),
    )
    );
  }
}
