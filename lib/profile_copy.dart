import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_test/components/edit_text.dart';
import 'package:map_test/components/squircle_button.dart';
import 'package:map_test/firebase_functions.dart';
import 'package:map_test/rylans_login_screen.dart';
import 'package:map_test/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class ProfileCopy extends StatefulWidget {
  const ProfileCopy({super.key});

  @override
  State<ProfileCopy> createState() => _ProfileCopyState();
}

class _ProfileCopyState extends State<ProfileCopy> {
  String? _image;
  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String> saveProfile(BuildContext context, Uint8List image) async {
    return await FirebaseFunctions.uploadProfilePic('profile_photos', image);
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? displayName = "user";
    // TextEditingController emailController = TextEditingController();
    // TextEditingController passwordController = TextEditingController();
    TextEditingController usernameController = TextEditingController();

    if (user != null) {
      usernameController.text = user.displayName!;
      // emailController.text = user.email!;
    }

    void selectImage(BuildContext context) async {
      Uint8List img = await pickImage(ImageSource.gallery);
      String? imageLink =
          await FirebaseFunctions.uploadProfilePic('profile_photos', img);
      setState(() {
        _image = imageLink;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Profile pic updated")));
      debugPrint('------------ $_image ------------');
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      selectImage(context);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: _image == null
                          ? const Icon(
                              Icons.person,
                              size: 60,
                            )
                          : Image.network(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  EditText(
                    controller: usernameController,
                    prefixLabel: 'Username',
                  ),
                  // EditText(
                  //   controller: emailController,
                  //   prefixLabel: "Email",
                  // ),
                  // EditText(
                  //   controller: passwordController,
                  //   prefixLabel: "Password",
                  // ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SquircleButton(
                          onTap: () {},
                          title: "Save changes",
                          textColor: Colors.green[900],
                          background: Colors.green[100],
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text("Dark mode"),
                          value: false,
                          onChanged: (value) {},
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SquircleButton(
                                  onTap: () {
                                    signOut();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  },
                                  title: "Sign out",
                                  textColor: Colors.red[900],
                                  background: Colors.red[100],
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ]),
    );
  }
}
