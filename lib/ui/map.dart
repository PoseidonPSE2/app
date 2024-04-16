import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return Center(child: Text('Home Screen'));
    return Center(child: content());
  }
}

Widget content() {
  return FlutterMap(
    options: MapOptions(
      initialCenter: LatLng(49.440067, 7.769000),
      initialZoom: 14,
      interactionOptions:
      const InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom),
    ),
    children: [
      openStreetMapTileLater,
      MarkerLayer(markers: [
        Marker(
          point: LatLng(49.440067, 7.769000),
          width: 60,
          height: 60,
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () {
              //_makeAPICall_post;
            },
            child: Icon(
              Icons.water_drop,
              size: 40,
              color: Colors.blue,
            ),
          ),
        ),
        Marker(
          point: LatLng(49.450000, 7.78000),
          width: 60,
          height: 60,
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () {
              //_makeAPICall_post;
            },
            child: Icon(
              Icons.water_drop,
              size: 40,
              color: Colors.blue,
            ),
          ),
        ),
      ]),
    ],
  );
}

TileLayer get openStreetMapTileLater => TileLayer(
  urlTemplate: 'https:/tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
);