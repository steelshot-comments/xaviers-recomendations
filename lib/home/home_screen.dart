import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_test/components/review_card.dart';
import 'package:map_test/post_review.dart';
import 'package:map_test/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'explore/explore_page.dart';
part 'home/home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    String? displayName = "user";
    if (user != null) {
      displayName = user.displayName;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text("Welcome ${displayName.toString()}!"),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Profile()));
                },
                icon: const Icon(Icons.person))
          ]),
      bottomNavigationBar: NavigationBar(
        indicatorShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: kToolbarHeight + 10,
        surfaceTintColor: Colors.white,
        onDestinationSelected: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        selectedIndex: currentPageIndex,
        indicatorColor: Color.fromRGBO(255, 215, 209, 1),
        backgroundColor: Colors.white,
        overlayColor: const MaterialStatePropertyAll(Colors.white),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: "Home"),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            label: "Explore",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PostReview()));
        },
        backgroundColor: const Color.fromRGBO(204, 91, 75, 1),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      body: const <Widget>[
        HomePage(),
        ExplorePage(),
      ][currentPageIndex],
    );
  }
}
