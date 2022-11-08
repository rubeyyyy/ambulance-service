import 'package:bhopu/drawer/SNavBar.dart';
import 'package:bhopu/screen/mainpge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SProfile extends StatefulWidget {
  @override
  State<SProfile> createState() => _SProfilePageState();
}

class _SProfilePageState extends State<SProfile> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SNavBar(),
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('service providers')
                .doc(_auth.currentUser!.uid)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {}
              var data = snapshot.data!.data();
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
                              border:
                                  Border.all(color: Colors.indigo, width: 5),
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
                      Column(children: <Widget>[
                        Text(
                          'Name: ' + data!['name'],
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Email: ' + data['email'],
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Phone Number: ' + data['ph_num'],
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut().then((value) =>
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MainPage())));
                            },
                            child: Text('LogOut'))
                      ]),
                    ],
                  ),
                ]),
              );
            })

        // return const Center(child: CircularProgressIndicator());

        );
  }
}
