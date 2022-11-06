import 'package:bhopu/screen/ambulanceUser.dart';
import 'package:bhopu/screen/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class booking extends StatefulWidget {
  final userid;
  const booking({Key? key, required this.userid}) : super(key: key);

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

  final TextEditingController _PatientName = TextEditingController();
  final TextEditingController _Age = TextEditingController();
  final TextEditingController _PhoneNoController = TextEditingController();
  final TextEditingController _Addfrom = TextEditingController();
  final TextEditingController _Addto = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  // final TextEditingController _Date = TextEditingController();
  //final TextEditingController _Time = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/5.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
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
                        controller: _PatientName,
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
                        controller: _Age,
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
                        controller: _PhoneNoController,
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
                      Text('Address from*'),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _Addfrom,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'choose';
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'choose', border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Address to*'),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _Addto,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'choose';
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'choose', border: OutlineInputBorder()),
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
                              color: Color.fromARGB(
                                  255, 109, 102, 102), //color of border
                              width: 0.5, //width of border
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        height: 60,
                        width: 500,
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                  "${selectedDate.toLocal()}".split(' ')[0]),
                            ),
                            Positioned(
                              bottom: 7,
                              right: 10,
                              child: ElevatedButton(
                                onPressed: () => _selectDate(context),
                                child: Text('Select date'),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 30, 140, 190))),
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
                              color: Color.fromARGB(
                                  255, 109, 102, 102), //color of border
                              width: 0.5, //width of border
                            ),
                            borderRadius: BorderRadius.circular(5)),
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
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 30, 140, 190))),
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
                              FirebaseFirestore.instance
                                  .collection('service providers')
                                  .doc(widget.userid)
                                  .collection('Notification')
                                  .add({
                                'PatientName': _PatientName.text,
                                 'Age': int.parse(_Age.text),
                                  'PhoneNo':int.parse( _PhoneNoController.text),
                                  //'Age': _Age.text,
                                //'PhoneNo': _PhoneNoController.text,
                                'AddFrom': _Addfrom.text,
                                'AddTo': _Addto.text,
                                'Date': selectedDate,
                                'Time': selectedTime,
                                'UserId': _auth.currentUser!.uid
                              }).then((value) {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(_auth.currentUser!.uid)
                                    .collection('MyBookings').doc(value.id)
                                    .set({
                                  'PatientName': _PatientName.text,
                                  'Age': int.parse(_Age.text),
                                  'PhoneNo':int.parse( _PhoneNoController.text),
                                  'AddFrom': _Addfrom.text,
                                  'AddTo': _Addto.text,
                                  'Date': selectedDate,
                                  'Time': selectedTime,
                                  'ServiceProviderId': widget.userid
                                });
                                //.then((value) {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               const dashboard()));
                                // });
                              });
                              showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          
                          content: const Text('You will be informed shortly after'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>dashboard(),
                                            ),
                                          );
                                        },
                              child: Text('OK', style: TextStyle(color: Colors.white),),
                              style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 30, 140, 190))),
                            ),
                          ],
                        ),
                      );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}