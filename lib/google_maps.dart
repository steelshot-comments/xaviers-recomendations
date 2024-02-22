import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url =
    Uri.parse('https://www.google.com/maps/search/?api=1&query=kayani+bakery');

class OpenMaps extends StatelessWidget {
  const OpenMaps({super.key});

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _launchUrl;
        },
        child: const Text("Search"),
      ),
    );
  }
}
