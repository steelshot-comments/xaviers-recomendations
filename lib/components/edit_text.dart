import 'package:flutter/material.dart';

class EditText extends StatelessWidget {
  const EditText({super.key, required this.controller, this.prefixLabel});

  final String? prefixLabel;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    String? prefixText = prefixLabel == "" ? null : prefixLabel;
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixText: prefixText,
      ),
    );
  }
}
