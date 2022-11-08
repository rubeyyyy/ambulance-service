// import 'package:bhopu/screen/mainpge.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const MainPage(),
//     );
//   }
// }

import 'package:bhopu/screen/login.dart';
import 'package:bhopu/screen/mainpge.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {'login': (context) => const MainPage()},
  ));
}
