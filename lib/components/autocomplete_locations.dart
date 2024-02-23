import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AutocompleteLocations extends StatelessWidget {
  const AutocompleteLocations({super.key, required this.options});

  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return options.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}
