//import 'dart:html';

import 'package:bhopu/screen/complaints.dart';
import 'package:bhopu/screen/list.dart';
import 'package:bhopu/screen/login.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context)
        .pop(); //oesnot show side bar when pressed back button from pages

    switch (index) {
      case 0:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context)=> AdminDashboard(),
        //   ),);
        break;
      case 1:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context)=> CandidateList(),
        //   ),);
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ListPage(),
          ),
        );
        break;
      case 3:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => complaints(),
          ),
        );
        break;
      case 4:
        FirebaseAuth.instance.signOut().then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyLogin()),
          );
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        //remove padding
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("I"),
            accountEmail: const Text('...'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/image/avatar.jpg',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(223, 131, 186, 231),
              // image: DecorationImage(
              //   fit: BoxFit.fill,
              //   image: AssetImage('assets/image/1.JPEG'),
              //   ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text('profile'),
            onTap: () => selectedItem(context, 0),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('History'),
            onTap: () => selectedItem(context, 1),
          ),
          ListTile(
            leading: const Icon(Icons.medical_services_outlined),
            title: const Text('List of ambulance'),
            onTap: () => selectedItem(context, 2),
          ),
          // ListTile(
          //   leading:const Icon(Icons.pages),
          //   title: const Text('About us'),
          //   onTap: ()=> selectedItem(context ,3),
          // ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Complaints'),
            onTap: () => selectedItem(context, 3),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => selectedItem(context, 4),
          ),
        ],
      ),
    );
  }
}
