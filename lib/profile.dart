import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_test/auth/auth_screen.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const AuthScreen()));
          },
          child: const Text("Sign out")),
    );
  }
}
