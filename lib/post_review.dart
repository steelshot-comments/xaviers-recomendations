import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_test/components/autocomplete_locations.dart';
import 'package:map_test/components/review_rating_bar.dart';
import 'package:map_test/components/review_card_description_box.dart';

class PostReview extends StatelessWidget {
  PostReview({super.key});

  CollectionReference students =
        FirebaseFirestore.instance.collection('myStudents');

  @override
  Widget build(BuildContext context) {
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
              // Container(
              //     padding: const EdgeInsets.all(5),
              //     child: TextField(
              //       cursorColor: const Color.fromRGBO(204, 91, 75, 1),
              //       // autovalidateMode: AutovalidateMode.always,
              //       // controller: controller,
              //       decoration: InputDecoration(
              //           prefixIcon: const Icon(Icons.search),
              //           border: const OutlineInputBorder(
              //               borderRadius: BorderRadius.all(Radius.circular(10))),
              //           hintText: "Enter a location",
              //           hintStyle: TextStyle(color: Colors.grey[700])),
              //     ),
              // ),
              const AutocompleteLocations(options: []),
              const DescriptionBox(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Rating(
                    iconSize: 35,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(204, 91, 75, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    onPressed: () {},
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
      ]),
    );
  }
}
