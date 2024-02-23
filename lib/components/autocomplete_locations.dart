import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AutocompleteLocations extends StatefulWidget {
  const AutocompleteLocations({super.key});

  @override
  State<AutocompleteLocations> createState() => _AutocompleteLocationsState();
}

class _AutocompleteLocationsState extends State<AutocompleteLocations> {
  Future<List<String>> fetchLocations(String query) async {
    QuerySnapshot<Map<String, dynamic>> locations = await FirebaseFirestore
        .instance
        .collection('locations')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    return locations.docs.map((doc) => doc['name'] as String).toList();
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        return await fetchLocations(textEditingValue.text);
      },
      onSelected: (String selection) {
        // Handle the selected suggestion
        debugPrint('Selected: $selection');
      },
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
        return TextField(
          controller: _searchController,
          decoration: InputDecoration(labelText: 'Search for a location'),
          onChanged: (value) {
            onEditingComplete();
            setState(() {});
          },
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Material(
          elevation: 4.0,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              final String option = options.elementAt(index);
              return ListTile(
                title: Text(option),
                onTap: () {
                  onSelected(option);
                },
              );
            },
          ),
        );
      },
    );
  }
}
