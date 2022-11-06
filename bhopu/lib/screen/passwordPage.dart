import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class passwordPage extends StatefulWidget {
  const passwordPage({Key? key}) : super(key: key);

  @override
  State<passwordPage> createState() => _passwordPageState();
}

class _passwordPageState extends State<passwordPage> {
  TextEditingController _emailTextController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//Login text

    Widget TopText2 = const Center(
      child: Text(
        "Forgot your password?",
        style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            fontSize: 16,

      ),
    ));

    Widget TopText = Center(
      child: Text(
        'Lets get your account back!',
        style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            fontSize: 30,
        ),
      ),
    );

    Widget EmailOrUsername = TextFormField(
      keyboardType: TextInputType.name,
      controller: _emailTextController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field cannot be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0),),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        labelText: 'Enter your email or username',
        filled: true,
        contentPadding: EdgeInsets.all(20.0),
      ),
    );


    Widget LoginButton = Center(
      child: SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: resetPassword,
          child: const Text(
            'Reset Password',
            style:
            TextStyle(fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ),
      ),
    );


    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TopText2,
                  TopText,
                  SizedBox(height: 10),
                  EmailOrUsername,
                  SizedBox(height: 30),
                  LoginButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailTextController.text.toString().trim());
      Fluttertoast.showToast(msg: "Email Reset Sent!");
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
      Navigator.of(context).pop();
    }
  }
}
