import 'package:bhopu/screen/navbar.dart';
import 'package:flutter/material.dart';
// import 'package:custom_switch/custom_switch.dart'; 

class serviceDashboard extends StatefulWidget {
  const serviceDashboard({ Key? key }) : super(key: key);


  @override
  State<serviceDashboard> createState() => _serviceDashboardState();
}

class _serviceDashboardState extends State<serviceDashboard> {
  bool isSwitched = false;  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Bhopu'),
      backgroundColor: Color.fromARGB(255, 113, 174, 202),
      ),
      drawer: NavBar(),
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                 
                 Column(
                  mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                         
               Text('Availability', 
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, fontFamily: 'Montserrat', color: Colors.black),),
 
     Text('Please turn off availability while you are engaged', 
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, fontFamily: 'Montserrat', color: Colors.black),),
    
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
              activeTrackColor: Color.fromARGB(255, 231, 187, 170),
              activeColor: Color.fromARGB(232, 185, 81, 74),
            
          ) 
            ),
             
        ]
        ),
        

      ),
    
    );
  }
}