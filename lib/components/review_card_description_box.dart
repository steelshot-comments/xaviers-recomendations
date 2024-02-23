import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class DescriptionBox extends StatefulWidget {
  const DescriptionBox({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<DescriptionBox> createState() => _DescriptionBoxState();
}

class _DescriptionBoxState extends State<DescriptionBox> {
  @override
  Widget build(BuildContext context) {
    String counter = "";

    return TextField(
      controller: widget.controller,
      onChanged: (value) {
        setState(() {
          counter = (220 - value.length).toString();
        });
      },
      maxLength: 220,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLines: 3,
      decoration: const InputDecoration(
          labelText: "Write a description...",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // hintText: "Write a description...",
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(255, 106, 84, 1)))),
    );
  }
}
