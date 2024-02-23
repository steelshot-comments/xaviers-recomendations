import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatefulWidget {
  const Rating({super.key, required this.iconSize, required this.onRatingChanged});

  final double iconSize;
  final Function(double) onRatingChanged;

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        itemSize: widget.iconSize,
        glow: false,
        initialRating: 3,
        minRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
              Icons.star_rounded,
              color: Color(0xfff4b042),
            ),
        onRatingUpdate: widget.onRatingChanged);
  }
}
