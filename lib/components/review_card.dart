import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.locationName,
    required this.author,
    required this.description,
    required this.category,
    required this.rating,
  });

  final String locationName;
  final String author;
  final String description;
  final String category;
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Card(
      // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // Set the clip behavior of the card
      clipBehavior: Clip.antiAliasWithSaveLayer,
      // Define the child widgets of the card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
          Image.network(
            "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=2073&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          // Add a container with padding that contains the card's title, text, and buttons
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Display the card's title using a font size of 24 and a dark grey color
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
                // Add a space between the title and the text
                Container(height: 10),
                // Display the card's text using a font size of 15 and a light grey color
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                ),
                // Add a row with two buttons spaced apart and aligned to the right side of the card
                Row(
                  children: <Widget>[
                    // Add a spacer to push the buttons to the right side of the card
                    const Spacer(),
                    // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
                    TextButton(
                      child: const Text(
                        "SHARE",
                        // style: TextStyle(color: MyColorsSample.accent),
                      ),
                      onPressed: () {},
                    ),
                    // Add a text button labeled "EXPLORE" with transparent foreground color and an accent color for the text
                    TextButton(
                      child: const Text(
                        "EXPLORE",
                        // style: TextStyle(color: MyColorsSample.accent),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Add a small space between the card and the next widget
          Container(height: 5),
        ],
      ),
    );
  }
}
