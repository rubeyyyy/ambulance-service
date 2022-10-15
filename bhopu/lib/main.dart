import 'package:bhopu/screen/login.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
    'login': (context)=>mylogin()},
  ));
}

