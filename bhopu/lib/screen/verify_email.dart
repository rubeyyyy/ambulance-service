import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bhopu/screen/dashboard.dart';

class VerifyMail extends StatefulWidget {
  const VerifyMail(String text, {Key? key}) : super(key: key);

  @override
  State<VerifyMail> createState() => _VerifyMailPageState();
}

class _VerifyMailPageState extends State<VerifyMail> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      //Utils.showSncakBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const dashboard()
      : Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Please Check Provided Email!!',
                  style: TextStyle(
                      fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
                ),
                const Text(
                  'A verification email has been sent to your email!!!',
                  style: TextStyle(
                      fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                    onPressed: () {
                      sendVerificationEmail();
                    },
                    icon: const Icon(
                      Icons.email_rounded,
                      size: 32,
                    ),
                    label: const Text(
                      'Resend Email',
                      style: TextStyle(
                          fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
                    )),
                TextButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: const Text('Cancel'))
              ],
            ),
          ),
        );
}
