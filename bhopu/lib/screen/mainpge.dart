import 'package:bhopu/screen/dashboard.dart';
import 'package:bhopu/screen/login.dart';
import 'package:bhopu/screen/serviceDashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(_auth.currentUser!.uid);
              print('#####*****************');
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(_auth.currentUser!.uid)
                  .get()
                  .then((uid) {
                if (uid.exists) {
                  return dashboard();
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(builder: (context) => const dashboard()));
                } else {
                  return serviceDashboard();
                }
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //   builder: (context) => const serviceDashboard()));
              });
              // return const dashboard();
            }
            return const MyLogin();
          },
        ),
      ),
    );
  }
}
