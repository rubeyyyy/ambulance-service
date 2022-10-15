import 'package:flutter/material.dart';

class dashBoard extends StatefulWidget {
  const dashBoard({Key? key}) : super(key: key);

  @override
  State<dashBoard> createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: SingleChildScrollView(
       child: SafeArea(
         child: Column(children: [
           SizedBox(height: 200,),
           Center(child: Text('RUBSSS'
               '',style: TextStyle(fontSize: 40,color: Colors.red,fontWeight: FontWeight.bold),)),


         ],),
       ),
     ),

   );
  }
}
