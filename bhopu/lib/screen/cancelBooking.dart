import 'package:bhopu/screen/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class CancelBooking extends StatefulWidget {
  const CancelBooking({Key? key}) : super(key: key);

  @override
  State<CancelBooking> createState() => _CancelBookingState();
}

class _CancelBookingState extends State<CancelBooking>
    with SingleTickerProviderStateMixin {
      FirebaseAuth _auth=FirebaseAuth.instance;
  final CollectionReference _referenceList =
      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('MyBookings');
      late Stream<QuerySnapshot> _streamList;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _streamList = _referenceList.snapshots();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
   bool isAfterToday(Timestamp timestamp) {
    return DateTime.now().toUtc().isBefore(
        DateTime.fromMillisecondsSinceEpoch(
            timestamp.millisecondsSinceEpoch,
            isUtc: false,
        ).toUtc(),
    );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cancel Booking'),
        backgroundColor: Color.fromARGB(255, 113, 174, 202),
      ),
      body:SingleChildScrollView(
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
                                StreamBuilder<QuerySnapshot>(
                  stream: _streamList,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }
      
                    if (snapshot.connectionState == ConnectionState.active) {
                      QuerySnapshot querySnapshot = snapshot.data;
                      List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
                          querySnapshot.docs;
      
                      return ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: listQueryDocumentSnapshot.length,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot document =
                                listQueryDocumentSnapshot[index];
                             return isAfterToday(document['Date'])? Card(
                                // child: Container(
                                //   child: Text((document['name'])),
                                //   height: 20,
                                // ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Color.fromARGB(255, 238, 230, 230),
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Patient Name: ' + (document['PatientName']),
                                                style: TextStyle(fontSize: 15.0)),
                                            // Text('Phone No: ' + (document['PhoneNo']),
                                            //     style: TextStyle(fontSize: 15.0)),
                                            // Text(
                                            //     'Age.: ' +
                                            //         (document['Age']),
                                            //     style: TextStyle(fontSize: 15.0)),
                                            Text(
                                                'location from: ' +
                                                    (document['AddFrom']),
                                                style: TextStyle(fontSize: 15.0)),
                                                Text(
                                                'location To: ' +
                                                    (document['AddTo']),
                                                style: TextStyle(fontSize: 15.0)),
                                                 Text(
                                                'Date: ' +
                                                    (document['Date'].toDate().toString()),
                                                style: TextStyle(fontSize: 15.0)),
                                                 Text(
                                                'Time: ' +
                                                    (document['Time']),
                                                style: TextStyle(fontSize: 15.0)),
                                          ]),
                                          ElevatedButton(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.white),
                                        ),style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Color.fromARGB(
                                                        255, 30, 140, 190))),
                                        onPressed: () {
                                         showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          
                          content: const Text('Are you sure'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).collection('MyBookings').doc(document.id).delete().then((value) {
                                  FirebaseFirestore.instance.collection('service providers').doc(document['ServiceProviderId']).collection('Notification').doc(document.id).delete().then((value) {

                                  Navigator.push(
                                            context,
                                           MaterialPageRoute(
                                             builder: (context) =>dashboard(),

                                           ),
                                          );
                                  });
                                });
                                          
                                        },
                              child: Text('OK', style: TextStyle(color: Colors.white),),
                              style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 30, 140, 190))),
                            ),
                          ],
                        ),
                      );
                                        },
                                          )
                                    ],
                                    
                                  ),
                                )):Container();
                          });
                    }
      
                    return const Center(child: CircularProgressIndicator());
                  }),
      
                              ]
                          ),
                        )
                    ),
      ),
      );
  }
}
