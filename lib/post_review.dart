import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:map_test/components/autocomplete_locations.dart';
import 'package:map_test/components/review_rating_bar.dart';
import 'package:map_test/components/review_card_description_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostReview extends StatefulWidget {
  PostReview({super.key});

  @override
  State<PostReview> createState() => _PostReviewState();
}

class _PostReviewState extends State<PostReview> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    num rating = 0;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          const Expanded(child: Text("j")),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // const AutocompleteLocations(),
                TextField(
                  controller: controller,
                ),
                DescriptionBox(
                  controller: descriptionController,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Rating(
                        iconSize: 35,
                        onRatingChanged: (double value) {
                          setState(() {
                            rating = value;
                          });
                        }),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(204, 91, 75, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        CollectionReference reviews =
                            FirebaseFirestore.instance.collection('reviews');
                        await reviews.doc().set({
                          'location': controller.text,
                          'author': 'Yeshaya',
                          'category': 'travel',
                          'description': descriptionController.text,
                          'rating': rating,
                        }).then((value) => ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text("Posted!"))));
                      },
                      child: const Text(
                        "Post",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ]));
  }
}
