import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ComplaintsList extends StatefulWidget {
  late String title;

  ComplaintsList({Key? key}) : super(key: key);

  @override
  ComplaintsListState createState() => ComplaintsListState();
}

class ComplaintsListState extends State<ComplaintsList> {
  final CollectionReference ComplaintsList =
      FirebaseFirestore.instance.collection('Complaints');
  late Stream<QuerySnapshot> _streamList;

  @override
  initState() {
    super.initState();
    _streamList = ComplaintsList.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint List'),
        backgroundColor: Color.fromARGB(255, 113, 174, 202),
      ),
      body: SingleChildScrollView(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Name: ' + (document['name']),
                                        style: TextStyle(fontSize: 15.0)),
                                    Text('Email: ' + (document['email']),
                                        style: TextStyle(fontSize: 15.0)),
                                    Text(
                                        'Complain Against: ' +
                                            (document['against']),
                                        style: TextStyle(fontSize: 15.0)),
                                    Text(
                                        'Complaint: ' + (document['complaint']),
                                        style: TextStyle(fontSize: 15.0)),
                                  ]),
                            ));
                      });
                }

                return const Center(child: CircularProgressIndicator());
              }),
        ],
      )),
    );
  }
}