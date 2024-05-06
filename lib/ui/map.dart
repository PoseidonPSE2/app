import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapScreen> {
  List<WaterStationMarker> waterStations = [];

  @override
  void initState() {
    super.initState();
    fetchWaterStations();
  }

  Future<void> fetchWaterStations() async {
    // Replace with your actual water station data fetching logic
    // (e.g., API call, local storage, etc.)
    // For demonstration purposes, create some dummy data
    final dummyData = [
      {
        "name": "Wasserstation Kaiserslautern",
        "description": "Öffentliche Trinkwasserstation",
        "latitude": 49.440067,
        "longitude": 7.749126
      },
      {
        "name": "Wasserstation Lauterstraße",
        "description": "Öffentliche Trinkwasserstation",
        "latitude": 49.447687,
        "longitude": 7.760024
      },
      // Add more water stations here...
    ];

    setState(() {
      waterStations = dummyData
          .map((station) => WaterStationMarker(
        position: LatLng((station["latitude"] as double),
            (station["longitude"] as double)),
        name: station["name"] as String,
        description: station["description"] as String,
      ))
          .toList();
    });
  }

  void showMarkerInfoPopup(BuildContext context, String name, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(name),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(49.440067, 7.749126),
        initialZoom: 13,
        minZoom: 10,
        maxZoom: 18,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: waterStations.map((marker) => Marker(
            point: marker.position,
            width: 80.0,
            height: 80.0,
            child: GestureDetector(
              onTap: () => showMarkerInfoPopup(context, marker.name, marker.description),
              child: marker.child,
            ),
          )).toList(),
        ),
      ],
    );
  }
}

class WaterStationMarker extends Marker {
  final String name;
  final String description;
  final LatLng position;

  static final Widget markerChild = Container(
    child: Icon(
      Icons.water_drop,
      size: 40,
      color: Colors.blueAccent,
    ),
  );

  WaterStationMarker({
    required this.position,
    required this.name,
    this.description = '',
  }) : super(point: position, child: markerChild);
}
