// ignore_for_file: camel_case_types

import 'package:bhopu/model/user_model.dart';
import 'package:bhopu/screen/dashboard.dart';
import 'package:bhopu/screen/verify_email.dart';
import 'package:bhopu/screen/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class registerUser extends StatefulWidget {
  const registerUser({Key? key}) : super(key: key);

  @override
  State<registerUser> createState() => _registerUserState();
}

class _registerUserState extends State<registerUser> {
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  final bool _isPasswordHidden = true;

  // string for displaying the error Message
  String? errorMessage;

  final nameEditingController = TextEditingController();
  final phonenumEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/2.JPEG'), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                          text: const TextSpan(
                              text: 'User Signup',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 8, 12),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold))),

                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Please enter your data to create account.',
                        style: TextStyle(
                            fontSize: 13, color: Color.fromARGB(255, 0, 8, 12)),
                      ),

                      //name

                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Full Name*'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: nameEditingController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');

                          if (value!.isEmpty) {
                            return ("Enter your Name");
                          }
                          if (value.split(" ").length == 1) {
                            return 'Enter your full name';
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid name(Min. 3 Character)");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          nameEditingController.text = value!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Enter your full name',
                            border: OutlineInputBorder()),
                      ),

                      //phone number

                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Phone Number*'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: phonenumEditingController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your Mobile';
                          }
                        },
                        onSaved: (value) {
                          phonenumEditingController.text = value!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Enter your phone number',
                            border: OutlineInputBorder()),
                      ),

                      //email

                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Email*'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailEditingController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter Your Email");
                          }

                          // reg expression for email validation
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailEditingController.text = value!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Enter your Email',
                            border: OutlineInputBorder()),
                      ),

                      //password

                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Password'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordEditingController,
                        obscureText: _isPasswordHidden,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return ("Password is required for login");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid Password(Min. 6 Character)");
                          }
                        },
                        onSaved: (value) {
                          passwordEditingController.text = value!;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key),
                          hintText: 'Enter your password',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      //confirm password

                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Re-enter Password'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: confirmPasswordEditingController,
                        obscureText: true,
                        validator: (value) {
                          if (confirmPasswordEditingController.text !=
                              passwordEditingController.text) {
                            return "Password don't match";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          confirmPasswordEditingController.text = value!;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Re-enter your password',
                            border: OutlineInputBorder()),
                      ),

                      //submit button

                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton(
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            signUp(emailEditingController.text,
                                passwordEditingController.text);
                            //VerifyMail(emailEditingController.text);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 30, 140, 190))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      //already have account
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account, "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MyLogin()));
                              },
                              child: const Text(
                                "Login",
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
        ));
  }

  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) async {
          Fluttertoast.showToast(msg: e!.message);
        });
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

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = nameEditingController.text;
    userModel.phonenum = phonenumEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "waiting for email verification :) ");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => dashboard()), (route) => false);
  }
}
