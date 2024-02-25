import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_test/auth/auth_screen.dart';
import 'package:map_test/components/edit_text.dart';
import 'package:map_test/components/profile_photo.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? displayName = "user";
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    if (user != null) {
      displayName = user.displayName;
      emailController.text = user.email!;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(250, 239, 219, 1),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 300,
                child: Column(children: [
                  Row(
                    children: [
                      const ProfilePhoto(),
                      Text(
                        displayName!,
                        style: const TextStyle(fontSize: 32),
                      ),
                    ],
                  ),
                  EditText(controller: emailController, prefixLabel: "Email",),
                  EditText(controller: passwordController, prefixLabel: "Password",)
                ]),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              SwitchListTile(
                  title: const Text("Dark mode"),
                  value: false,
                  onChanged: (value) {}),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: () {
                    signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthScreen()));
                  },
                  child: const Text("Delete account"),
                ),
                ElevatedButton(
                  onPressed: () {
                    signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthScreen()));
                  },
                  child: const Text("Sign out"),
                ),
              ]),
            ],
          ),
        ),
      ]),
    );
  }
}
