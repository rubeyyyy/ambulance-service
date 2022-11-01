import 'package:bhopu/screen/login.dart';
import 'package:bhopu/screen/mainpge.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //initialRoute: 'login',
    home: MainPage(),
    //routes: {'login': (context) => const MainPage()},
  ));
}
