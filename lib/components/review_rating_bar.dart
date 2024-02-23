import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatelessWidget {
  const Rating({super.key, required this.iconSize});

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: iconSize,
      glow: false,
      initialRating: 3,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star_rounded,
        color: const Color(0xfff4b042),
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
