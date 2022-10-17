import 'package:flutter/material.dart';
import 'package:bhopu/screen/passwordPage.dart';
import 'package:bhopu/screen/registerChoice.dart';
import 'package:bhopu/screen/dashboard.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({ Key? key }) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  var _formkey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/image/1.JPEG'), fit: BoxFit.cover
        )
      ),
      child:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: Scaffold(
        backgroundColor: Colors.transparent,

        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 250),
          child: SafeArea(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your phone or email';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter your phone or email',
                        labelText: 'Phone or Email',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: _isPasswordHidden,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter the password';
                      }
                    },
                    decoration: InputDecoration(
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
                          style: TextStyle(color: Color.fromARGB(255, 30, 140, 190),fontSize: 10),
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => dashboard(),
                              ),
                            );
                          }
                        },
                        
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 30, 140, 190),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),),
                  
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
                            style: TextStyle(color:Color.fromARGB(255, 30, 140, 190)),
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
}