import 'package:flutter/material.dart';

class passwordPage extends StatefulWidget {
  const passwordPage({Key? key}) : super(key: key);

  @override
  State<passwordPage> createState() => _passwordPageState();
}

class _passwordPageState extends State<passwordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [Text('I am password page')],
      ),
    );
  }
}
