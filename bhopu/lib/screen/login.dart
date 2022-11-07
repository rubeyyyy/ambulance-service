import 'package:bhopu/admin/admin_page.dart';
import 'package:bhopu/screen/dashboard.dart';
import 'package:bhopu/screen/serviceDashboard.dart';
import 'package:bhopu/screen/userMap.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:bhopu/screen/passwordPage.dart';
import 'package:bhopu/screen/registerChoice.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:bhopu/model/servicepro_model.dart';
import 'package:bhopu/model/user_model.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _formkey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;

  //firebase
  final _auth = FirebaseAuth.instance;
  UserModel loggedInUser = UserModel(Longitude: 0, Latitude: 0);
  ServiceModel loggedInDriver = ServiceModel(Longitude: 0, Latitude: 0);

  // editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image/1.JPEG'), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 250),
            child: SafeArea(
              //form
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //email field
                    const SizedBox(
                      height: 50,
                    ),

                    TextFormField(
                        controller: emailController,
                        keyboardType:
                            TextInputType.emailAddress, //suggest @ and . key

                        //validation
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your phone or email';
                          }

                          //reg expression for email validator
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Enter your email',
                            labelText: 'Email',
                            border: OutlineInputBorder())),

                    //password
                    const SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      obscureText: _isPasswordHidden,
                      controller: passwordController,
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return 'Enter the password';
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Enter Valid Password(Min. 6 Character)");
                        }
                      },
                      onSaved: (value) {
                        passwordController.text = value!;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key),
                        hintText: 'Enter your password',
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordHidden
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isPasswordHidden = !_isPasswordHidden;
                            });
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => passwordPage()));
                          },
                          child: Text(
                            "\nForget Password?",
                            style: TextStyle(
                                color: Color.fromARGB(255, 30, 140, 190),
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),

                    //login button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          signIn(emailController.text, passwordController.text);
                        },
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 30, 140, 190),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(" Don't have an account?, "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => registerChoice()));
                            },
                            child: Text(
                              "sign up",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 30, 140, 190)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //login function
  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          print("**************LOGIN SUCESS");
          if (email == 'admin@bhopu.com') {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AdminPage()));
          } else {
            FirebaseFirestore.instance
                .collection('users')
                .doc(_auth.currentUser!.uid)
                .get()
                .then((uid) {
              if (uid.exists) {
                print('***********************Exist');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => dashboard()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => serviceDashboard()));
              }
            }).onError((error, stackTrace) {
              Fluttertoast.showToast(
                  msg: '***********************does not Exist');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => dashboard()));
            });
          }
        });
        // .then((uid) => {
        Fluttertoast.showToast(msg: "Login Successful");
        print(_auth.currentUser!.uid);
        print('#############################S');

        //if(_auth.currentUser!.uid)

      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
