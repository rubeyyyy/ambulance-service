import 'package:bhopu/screen/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class booking extends StatefulWidget {
  const booking({ Key? key }) : super(key: key);

  @override
  State<booking> createState() => _bookingState();
}

class _bookingState extends State<booking> {

   var _formkey = GlobalKey<FormState>();
   DateTime selectedDate = DateTime.now();
   String? selectedTime;

  Future<void> _displayTimeDialog(BuildContext context) async {
    final TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        selectedTime = time.format(context);
      });
    }
    }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
    
    
  }


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
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                   ),
                  RichText(
                      text: TextSpan(
                          text: 'Enter Booking details',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 8, 12),
                              fontSize: 30,
                              fontWeight: FontWeight.bold))),
                  SizedBox(
                    height: 20,
                  ),
                  
                  Text('Name of patient*'),

                  SizedBox(
                    height: 10,
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
                  Text('Age*'),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your Age';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter your phone number',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Phone Number*'),
                  SizedBox(
                    height: 10,
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
                  Text('Address*'),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'choose';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'choose',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  
                  Text('Date'),
                  SizedBox(
                    height: 10,
                  ),
              Container(
                    decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromARGB(255, 109, 102, 102), //color of border
                        width: 0.5, //width of border
                      ),
                    borderRadius: BorderRadius.circular(5)
                  ),
                    height: 60,
                    width: 500,
                    
                    child: Stack(
                    children: [
                      Container(
              padding: EdgeInsets.all(15.0),
                      child: Text("${selectedDate.toLocal()}".split(' ')[0]),
                      ),
                      Positioned(
                      bottom: 7,
                      right: 10,
                      child: ElevatedButton(
                        
                            onPressed: () => _selectDate(context),
                            child: Text('Select date'),
                            style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 30, 140, 190))),
                          ),
                      ),
                      
                    ],
                  ),
              ),

                SizedBox(
                     height: 20,
                    ),
                                  
                                  Text('Time'),
                                  SizedBox(
                                    height: 10,
                                  ),

                Container(
                      decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 109, 102, 102), //color of border
                          width: 0.5, //width of border
                        ),
                      borderRadius: BorderRadius.circular(5)
                    ),
                      height: 60,
                      width: 500,
                      
                      child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15.0),
                        child: Text(
                            selectedTime != null
                                ? '$selectedTime'
                                : 'Select time',
                            
                          ),
                        ),
                        Positioned(
                        bottom: 7,
                        right: 10,
                        child: ElevatedButton(
                          
                            onPressed: () => _displayTimeDialog(context),
                              child: Text('Select Time'),
                              style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 30, 140, 190))),
                            ),
                        ),
                        
                      ],
                    ),
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
          ),
        ),
      ),
    )
    );
  }
}