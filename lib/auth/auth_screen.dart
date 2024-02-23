import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import 'package:map_test/components/auth_button.dart';
import 'package:map_test/components/input.dart';

part 'firebase_functions.dart';
part 'auth_form.dart';
part 'auth_img_component.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    const AuthImgComponent(),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1100),
                      child: Column(children: [
                        const Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Verify your email to use the app",
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        )
                      ]),
                    ),
                    const AuthForm(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
