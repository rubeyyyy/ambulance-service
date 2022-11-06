import 'package:flutter/material.dart';

class passwordPage extends StatefulWidget {
   static String id = 'forgot-password';
  const passwordPage({Key? key}) : super(key: key);

  @override
  State<passwordPage> createState() => _passwordPageState();
}

class _passwordPageState extends State<passwordPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Email Your Email',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              TextFormField(

                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      icon: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      errorStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Send Email'),
                onPressed: () {},
              ),
              ElevatedButton(
                child: Text('Sign In'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
     ) );
  }
}
