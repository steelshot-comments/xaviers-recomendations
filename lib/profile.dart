import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:map_test/auth/auth_screen.dart';
import 'package:map_test/components/edit_text.dart';
// import 'package:map_test/components/profile_photo.dart';
import 'package:map_test/components/squircle_button.dart';
import 'package:map_test/firebase_functions.dart';
import 'package:map_test/rylans_login_screen.dart';
import 'package:map_test/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    if (user != null) {
      displayName = user.displayName;
      emailController.text = user.email!;
    }

    void selectImage(BuildContext context) async {
      Uint8List img = await pickImage(ImageSource.gallery);
      String? imageLink =
          await FirebaseFunctions.uploadProfilePic('profile_photos', img);
      setState(() {
        _image = imageLink;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Profile pic updated")));
      debugPrint('------------ $_image ------------');
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(204, 91, 75, 1),
                Color.fromRGBO(255, 106, 84, 1),
              ],
              begin: Alignment(0, -1),
              end: Alignment(0, 1),
            ),
            // color: Color.fromRGBO(204, 91, 75, 1),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 300,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              selectImage(context);
                            },
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(8.0), //or 15.0
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
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
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            displayName!,
                            style: const TextStyle(
                                fontSize: 32, color: Colors.white),
                          ),
                        ],
                      ),
                      EditText(
                        controller: emailController,
                        prefixLabel: "Email",
                      ),
                      EditText(
                        controller: passwordController,
                        prefixLabel: "Password",
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SquircleButton(
                              onTap: () {},
                              title: "Save changes",
                              textColor: const Color.fromRGBO(255, 106, 84, 1),
                              background: Colors.white,
                            ),
                          ),
                        ],
                      ),
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
                onChanged: (value) {},
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SquircleButton(
                  onTap: () {
                    signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  title: "Sign out",
                  textColor: const Color.fromRGBO(255, 106, 84, 1),
                  background: const Color.fromRGBO(255, 215, 209, 1),
                ),
                // SquircleButton(
                //   onTap: () {
                //     Navigator.pushReplacement(context,
                //         MaterialPageRoute(builder: (context) => const LoginApp()));
                //   },
                //   title: "Delete account",
                //   textColor: const Color.fromRGBO(255, 106, 84, 1),
                //   background: const Color.fromRGBO(255, 215, 209, 1),
                // ),
              ]),
            ],
          ),
        ),
      ]),
    );
  }
}
