import 'package:bhopu/model/info_card.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: ListView.builder(
            // itemCount: userdata == null ? 0 : userdata.length,
            itemBuilder: (context, index) {
          return SingleChildScrollView(
              child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.indigo, width: 5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/image/avatar.jpg',
                            fit: BoxFit.cover,
                            height: 200,
                            width: 200,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: InfoCard(
                            text: 'List1',
                            icon: Icons.account_circle,
                            onPressed: () {}),
                      ),
                      Container(
                        child: InfoCard(
                            text: 'List1', icon: Icons.mail, onPressed: () {}),
                      ),
                      Container(
                        child: InfoCard(
                            text: 'List1', icon: Icons.phone, onPressed: () {}),
                      ),
                      Container(
                        child: InfoCard(
                            text: 'List1', icon: Icons.boy, onPressed: () {}),
                      ),
                      Container(
                        child: InfoCard(
                            text: 'List1', icon: Icons.home, onPressed: () {}),
                      ),
                      Container(
                        child: InfoCard(
                            text: 'List1',
                            icon: Icons.add_outlined,
                            onPressed: () {}),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ));
        }));
  }
}
