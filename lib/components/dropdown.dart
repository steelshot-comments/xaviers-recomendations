import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({super.key, required this.options});
  final List<String> options;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    List<String> options = widget.options;

    return DropdownButton<String>(
      value: dropdownValue,
      items: options.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        if (value != null) {
          setState(() {
            dropdownValue = value;
          });
          debugPrint(dropdownValue);
        }
      },
    );
  }
}
