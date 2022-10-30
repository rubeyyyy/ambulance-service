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
            SizedBox(
            height: 30,
          ),
           Text("Your location",style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, fontFamily: 'Montserrat', color: Colors.black),),
          Container(
            //yesma map
          ), 
            SizedBox(
            height: 10,
          ),
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
          ),
          ),
        
          SizedBox(
            height: 30,
          ),
          Text("You're Booked for:",style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, fontFamily: 'Montserrat', color: Colors.black),),
        
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