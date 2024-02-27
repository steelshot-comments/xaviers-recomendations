import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditText extends StatefulWidget {
  const EditText(
      {super.key, required this.controller, this.prefixLabel, this.fontSize});

  // final bool? isObscured;
  final String? prefixLabel;
  final TextEditingController? controller;
  final int? fontSize;

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  bool isEnabled = false;
  @override
  Widget build(BuildContext context) {
    String? prefixText = widget.prefixLabel == "" ? null : widget.prefixLabel;
    return Row(
      children: [
        Expanded(
          child: TextField(
            enabled: isEnabled,
            controller: widget.controller,
            decoration: InputDecoration(
              labelText: prefixText,
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                isEnabled = isEnabled == false ? true : false;
              });
            },
            icon: const Icon(Icons.edit))
      ],
    );
  }
}
