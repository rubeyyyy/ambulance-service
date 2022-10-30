import 'package:bhopu/screen/dashboard.dart';
import 'package:flutter/material.dart';

class complaints extends StatefulWidget {
  const complaints({ Key? key }) : super(key: key);

  @override
  State<complaints> createState() => _complaintsState();
}

class _complaintsState extends State<complaints> {
  var _formkey = GlobalKey<FormState>();
  String dropdownvalue = 'Service provider';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/image/2.JPEG'), fit: BoxFit.cover
        )
      ),
      child:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
      child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Complaints',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 8, 12),
                              fontSize: 30,
                              fontWeight: FontWeight.bold))),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Full Name*'),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your Name';
                      }
                      if (value.split(" ").length == 1) {
                        return 'Enter your full name';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter your full name',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Phone Number*'),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your Mobile';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter your phone number',
                        border: OutlineInputBorder()),
                  ),
                   SizedBox(
                    height: 20,
                  ),
                  Text('Complain Against'),
                  SizedBox(
                    height: 5,
                  ),
                  
                  DropdownButton<String>(
                    value: dropdownvalue,
                    items:
                        <String>['User', 'Service provider','Developer'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {setState(() {
                  dropdownvalue = newValue!;
                });},
                  ),

                SizedBox(
                    height: 20,
                  ),
                   Text('Complain Against ambulance number (if any)'),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(   
                    decoration: InputDecoration(
                        hintText: 'Enter your Ambulance number',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Write down Your Problem*'),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your Complaint';
                      }
                      
                    },
                    // decoration: InputDecoration(
                    //     border: OutlineInputBorder()
                      
                    //     ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => dashboard(),
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 30, 140, 190))),
                    ),
                  ),
                ],
              ),
            ),
    )
        )
        ),
      ),
    );
  }
}