import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({super.key});

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  Uint8List? _image;

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);

    if (file != null) {
      return await file.readAsBytes();
    } else {
      debugPrint("Error while uploading image");
    }
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectImage,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), //or 15.0
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
              : Image(
                  image: MemoryImage(_image!),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
