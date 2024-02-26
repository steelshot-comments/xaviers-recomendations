import 'package:flutter/material.dart';
import 'package:map_test/home/home_screen.dart';

class LocationCard extends StatelessWidget {
  const LocationCard(
      {super.key,
      required this.locationName,
      required this.image,
      required this.locationRef});

  final String locationName;
  final String image;
  final String locationRef;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LocationReviews(locationRef: locationRef,)));
      },
      child: Card(
        color: Colors.white,
        shadowColor: const Color.fromRGBO(255, 215, 209, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    locationName,
                    style: TextStyle(
                      fontSize: 24,
                      decoration: TextDecoration.underline,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
