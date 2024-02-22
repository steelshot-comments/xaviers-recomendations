import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(51.509364, -0.128928),
        initialZoom: 3.2,
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/yeshaya/clsvzurn4007901po2207fof3/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoieWVzaGF5YSIsImEiOiJjbHN2emw0eW4xN2syMnJtdXp0ZjYzN21hIn0.FoqcxWvKarmrqPGbyn3NJQ',
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoieWVzaGF5YSIsImEiOiJjbHN2emw0eW4xN2syMnJtdXp0ZjYzN21hIn0.FoqcxWvKarmrqPGbyn3NJQ',
            'id': 'mapbox.mapbox-streets-v8',
          },
        ),
      ],
    );
  }
}
