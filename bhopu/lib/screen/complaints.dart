import 'package:bhopu/model/complainModel.dart';
import 'package:bhopu/screen/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class complaints extends StatefulWidget {
  complaints({Key? key}) : super(key: key);

  @override
  State<complaints> createState() => _complaintsState();
}

class _complaintsState extends State<complaints> {
  var _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String dropdownvalue = 'Service provider';
  final nameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final complaintsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image/2.JPEG'), fit: BoxFit.cover)),
      child: Padding(
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
                      height: 10,
                    ),
                    TextFormField(
                      controller: nameEditingController,
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
                      onSaved: (value) {
                        nameEditingController.text = value!;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Email*'),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: emailEditingController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your Email';
                        }
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter your email',
                          border: OutlineInputBorder()),
                      onSaved: (value) {
                        emailEditingController.text = value!;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Complain Against'),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButton<String>(
                      value: dropdownvalue,
                      items: <String>['User', 'Service provider', 'Developer']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Write down Your Problem*'),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: complaintsController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your Complaint';
                        }
                      },
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      onSaved: (value) {
                        complaintsController.text = value!;
                      },
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
                            RecordComplaints();
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => dashboard(),
                            //  ),
                            // );
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 30, 140, 190))),
                      ),
                    ),
                  ],
                ),
              ),
            ))),
      ),
    );
  }

  RecordComplaints() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    ComplaintModel usercomplaints = ComplaintModel();

    // writing all the values
    usercomplaints.email = user!.email;
    usercomplaints.uid = user.uid;
    usercomplaints.name = nameEditingController.text;
    usercomplaints.against = dropdownvalue;
    usercomplaints.complaint = complaintsController.text;

    await firebaseFirestore
        .collection("Complaints")
        .doc(user.uid)
        .set(usercomplaints.toMap());
    Fluttertoast.showToast(msg: "Your complaint has been registered ");

    Navigator.pushAndRemoveUntil(
        (this.context),
        MaterialPageRoute(builder: (context) => const dashboard()),
        (route) => false);
  }
}
