import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarScreen extends StatefulWidget {
  const RatingBarScreen({Key? key}) : super(key: key);

  @override
  State<RatingBarScreen> createState() => _RatingBarScreenState();
}

class _RatingBarScreenState extends State<RatingBarScreen> {
  double fullRating = 0;
  double halfRating = 0;
  double emojiRating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Flutter Rating Bar"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 30,
          ),
     
          const Text(
            'Half & Full Rating Bar',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 24.0,
            ),
            textAlign: TextAlign.center,
          ),
          Center(
            child: RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              allowHalfRating: true,
              unratedColor: Colors.grey,
              itemCount: 5,
              itemSize: 50.0,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              updateOnDrag: true,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Color.fromARGB(255, 91, 134, 175),
              ),
              onRatingUpdate: (ratingvalue) {
                setState(() {
                  halfRating = ratingvalue;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Rating : $halfRating',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 24.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
       
          
        ],
      ),
    );
  }
}
