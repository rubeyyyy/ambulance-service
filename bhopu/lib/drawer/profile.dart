import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  final CollectionReference _referenceList =
      FirebaseFirestore.instance.collection('users');
  late Stream<QuerySnapshot> _streamList;

  @override
  initState() {
    super.initState();
    _streamList = _referenceList.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: StreamBuilder<QuerySnapshot>(
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

                  // itemCount: userdata == null ? 0 : userdata.length,
                  itemCount: listQueryDocumentSnapshot.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot document =
                        listQueryDocumentSnapshot[index];

                    return SingleChildScrollView(
                      child: Column(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Stack(children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.indigo, width: 5),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/image/avatar.jpg',
                                      fit: BoxFit.cover,
                                      height: 200,
                                      width: 200,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // Column(children: <Widget>[
                            //   Text(
                            //     'Name: ' + document['name'],
                            //     style: TextStyle(
                            //       fontSize: 50,
                            //       fontWeight: FontWeight.w300,
                            //       fontFamily: 'Montserrat',
                            //     ),
                            //   ),
                            //   SizedBox(
                            //     height: 10,
                            //   ),
                            //   Text(
                            //     'Email: ' + document['email'],
                            //     style: TextStyle(
                            //       fontSize: 50,
                            //       fontWeight: FontWeight.w300,
                            //       fontFamily: 'Montserrat',
                            //     ),
                            //   ),
                            //   SizedBox(
                            //     height: 10,
                            //   ),
                            //   Text(
                            //     'Phone Number: ' + document['ph_num'],
                            //     style: TextStyle(
                            //       fontSize: 50,
                            //       fontWeight: FontWeight.w300,
                            //       fontFamily: 'Montserrat',
                            //     ),
                            //   ),
                            //   SizedBox(
                            //     height: 10,
                            //   ),
                            //   Text(
                            //     ': ' + document[''],
                            //     style: TextStyle(
                            //       fontSize: 50,
                            //       fontWeight: FontWeight.w300,
                            //       fontFamily: 'Montserrat',
                            //     ),
                            //   ),
                            // ]),
                          ],
                        ),
                      ]),
                    );
                  });
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
