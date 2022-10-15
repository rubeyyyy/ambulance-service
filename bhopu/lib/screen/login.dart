import 'package:flutter/material.dart';

// ignore: camel_case_types
class mylogin extends StatefulWidget {
  const mylogin({ Key? key }) : super(key: key);

  @override
  State<mylogin> createState() => _myloginState();
}

// ignore: camel_case_types
class _myloginState extends State<mylogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/123.JPEG'), fit: BoxFit.cover
        )
      ),
    child:  Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            child: Text('login', style: TextStyle(color: Colors.black, fontSize: 40),),
            padding: EdgeInsets.only(left: 150 ,top: 250),
          ),
          Container(
            
          )
        ],
      ),
      
    ),
    );
  }
}