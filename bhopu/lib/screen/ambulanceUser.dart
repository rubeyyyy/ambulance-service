import 'package:bhopu/screen/booking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ambulanceUser extends StatefulWidget {
  late String title;

  @override
  ambulanceUserState createState() => ambulanceUserState();
}

class ambulanceUserState extends State<ambulanceUser> {
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
        title: Text('Bhopu'),
        backgroundColor: Color.fromARGB(255, 113, 174, 202),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          // height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //photo
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Name: ' + (document['name']),
                                                style:
                                                    TextStyle(fontSize: 15.0)),
                                            Text(
                                                'Phone No: ' +
                                                    (document['ph_num']),
                                                style:
                                                    TextStyle(fontSize: 15.0)),
                                            Text(
                                                'Ambulance No.: ' +
                                                    (document['amb_num']),
                                                style:
                                                    TextStyle(fontSize: 15.0)),
                                            Text(
                                                'Type: ' +
                                                    (document['type']
                                                        .toString()),
                                                style:
                                                    TextStyle(fontSize: 15.0)),
                                          ]),
                                      ElevatedButton(
                                        child: Text(
                                          "Book",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => booking(
                                                userid: document.id,
                                              ),
                                            ),
                                          );
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Color.fromARGB(
                                                        255, 30, 140, 190))),
                                      ),
                                    ],
                                  ),
                                ));
                          });
                    }

                    return const Center(child: CircularProgressIndicator());
                  }),
            ],
          ),
        )),
      ),
    );
  }
}