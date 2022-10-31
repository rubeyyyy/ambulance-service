import 'package:bhopu/screen/navbar.dart';
import 'package:flutter/material.dart';

class ambulanceList extends StatefulWidget {
  const ambulanceList({ Key? key }) : super(key: key);

  @override
  State<ambulanceList> createState() => _ambulanceListState();
}

class _ambulanceListState extends State<ambulanceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('List of Ambulances'),
      backgroundColor: Color.fromARGB(255, 113, 174, 202),
      ),
      drawer: NavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
             width: 400,  
            height: 120,  
            padding: new EdgeInsets.all(4.0),  
            child: Card(  
              shape: RoundedRectangleBorder(  
                borderRadius: BorderRadius.circular(15.0),  
              ),  
              color: Color.fromARGB(255, 238, 230, 230),  
              elevation: 10,  
               child: Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Column(  
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,  
                  children: <Widget>[    
                       Text(  
                        'Name:',  
                        style: TextStyle(fontSize: 15.0)  
                      ),
                      Text(  
                        'Phone number:',  
                        style: TextStyle(fontSize: 15.0)  
                      ),
                      Text(  
                        'Ambulance number:',  
                        style: TextStyle(fontSize: 15.0)  
                      ),
                      Text(  
                        'Ambulance Type:',  
                        style: TextStyle(fontSize: 15.0)  
                      ),
                      
              ]
            ),
           )
          ),
          ),
          ],
        ),
      ),
    );
  }
}