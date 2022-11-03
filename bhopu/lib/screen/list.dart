import 'dart:developer';
import 'dart:ffi';

import 'package:bhopu/model/servicepro_model.dart';
import 'package:bhopu/model/user_model.dart';
import 'package:bhopu/screen/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  late String title;

  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  final CollectionReference _referenceDriverList =
      FirebaseFirestore.instance.collection('service providers');
  late Stream<QuerySnapshot> _streamList;

  @override
  initState() {
    super.initState();
    _streamList = _referenceDriverList.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Ambulances'),
        backgroundColor: Color.fromARGB(255, 113, 174, 202),
      ),
      drawer: NavBar(),
      body: SingleChildScrollView(
          child: Container(
        // height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container(
            //   width: 400,
            //   height: 120,
            //   padding: const EdgeInsets.all(4.0),
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
                          return Card(
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
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Name: ' + (document['name']),
                                          style: TextStyle(fontSize: 15.0)),
                                      Text('Phone No: ' + (document['ph_num']),
                                          style: TextStyle(fontSize: 15.0)),
                                      Text(
                                          'Ambulance No.: ' +
                                              (document['amb_num']),
                                          style: TextStyle(fontSize: 15.0)),
                                      Text(
                                          'Type: ' +
                                              (document['type'].toString()),
                                          style: TextStyle(fontSize: 15.0)),
                                    ]),
                              ));
                        });
                  }

                  return const Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      )),
    );
  }
}
