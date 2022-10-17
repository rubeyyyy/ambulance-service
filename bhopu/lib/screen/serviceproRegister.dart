import 'package:bhopu/screen/login.dart';
import 'package:flutter/material.dart';

class servieproRegister extends StatefulWidget {
  const servieproRegister({Key? key}) : super(key: key);

  @override
  State<servieproRegister> createState() => _servieproRegisterState();
}

class _servieproRegisterState extends State<servieproRegister> {
  var _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        text: 'Create your account',
                        style: TextStyle(
                            color: Color.fromARGB(255, 30, 140, 190),
                            fontSize: 30,
                            fontWeight: FontWeight.bold))),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Please enter your data to create account.',
                  style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 122, 182, 231)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Full Name*'),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your Name';
                    }
                    if (value.split(" ").length == 1) {
                      return 'Enter your full name';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter your full name',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Phone Number*'),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your Mobile';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter your phone number',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Email*'),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your Email';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter your Email',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Password'),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password cannot be left empty';
                    }
                    if (value.length < 6) {
                      return 'Password must contains 6 charcters';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter your password',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Ambulance Number*'),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ambulance Number cannot be left empty';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter your Ambulanace Number',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Select the type of Ambulance*'),
                SizedBox(
                  height: 10,
                ),
                DropdownButton<String>(
                  items:
                      <String>['Equipped', 'Non Equipped'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyLogin(),
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 30, 140, 190))),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account, "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyLogin()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Color.fromARGB(255, 30, 140, 190)),
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
    );
  }
}