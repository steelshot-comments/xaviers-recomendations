import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard(
      {super.key,
      required this.locationName,
      required this.author,
      required this.description,
      required this.category,
      required this.rating,
      required this.image});

  final String locationName;
  final String author;
  final String description;
  final String category;
  final num rating;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Color.fromRGBO(255, 215, 209, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=2073&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: [
                  Text(
                    locationName,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[800],
                    ),
                  ),
                  Wrap(
                    children: [
                      Text(rating.toString()),
                      const Icon(Icons.star_rounded)
                    ],
                  )
                ]),
                Container(height: 10),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Spacer(),
                    TextButton(
                      child: const Text(
                        "SHARE",
                      ),
                      onPressed: () {},
                    ),
                    TextButton(
                      child: const Text(
                        "EXPLORE",
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
