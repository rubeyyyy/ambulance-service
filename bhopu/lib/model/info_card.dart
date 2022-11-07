import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  // const InfoCard({Key? key}) : super(key: key);
  final String text;
  final IconData icon;
  VoidCallback onPressed;

  InfoCard({required this.text, required this.icon, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 8,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 25), // styling of box
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.purple,
          ),
          title: Text(
            text,
            style: const TextStyle(
              color: Colors.purple,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
