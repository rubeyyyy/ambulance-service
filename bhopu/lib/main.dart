import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bhopu/screen/login.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {'login': (context) => const MyLogin()},
  ));
}
