import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hello_worl2/pages/WaterstationDetails.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

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
        "longitude": 7.749126,
        "image": "", // Add an image field to your data
        "address": "Jacobstarße 15, 67655 Kaiserslautern",
        "likes": 3,
        "isActive": true,
        "isAvailable": true,
        "rating": {
          " cleanliness": 3,
          " accessibility": 2,
          " Water quality": 1,
        }
      },
      {
        "name": "Wasserstation Lauterstraße",
        "description": "Öffentliche Trinkwasserstation",
        "latitude": 49.447687,
        "longitude": 7.760024,
        "image": "", // Add an image field to your data
        "address": "Lauferstraße 12, 67655 Kaiserslautern",
        "likes": 1,
        "isActive": true,
        "isAvailable": false,
        "rating": {
          " cleanliness": 3,
          " accessibility": 2,
          " Water quality": 1,
        }
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
                address: station["address"] as String,
                likes: station["likes"] as int,
                isActive: station["isActive"] as bool,
                isAvailable: station["isAvailable"] as bool,
                rating: station["rating"] as Map<String, int>,
              ))
          .toList();
    });
  }

  void navigateToDetailsPage(BuildContext context, WaterStationMarker marker) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Waterstationdetails(marker: marker),
      ),
    );
  }

  void showMarkerInfoPopup(BuildContext context, WaterStationMarker marker) {
    final isActiveText = marker.isActive ? 'Aktiv' : 'Inaktiv';
    final isAvailableText =
        marker.isAvailable ? 'Verfügbar' : 'Nicht verfügbar';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            //Image.network(marker.image, width: 100, height: 100),
            const SizedBox(width: 10),
            Expanded(child: Text(marker.name)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(marker.address),
            Text('Likes: ${marker.likes}'),
            Text('Status: $isActiveText - $isAvailableText'),
            Text('cleanliness: ${marker.rating[' cleanliness']}'),
            Text('accessibility: ${marker.rating[' accessibility']}'),
            Text('Water quality: ${marker.rating[' Water quality']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              // Handle report error button press
              // You can navigate to another screen or make an API call here
              print('Report error button pressed for ${marker.name}');
            },
            child: const Text('Fehler melden'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(49.440067, 7.749126),
        initialZoom: 13,
        minZoom: 10,
        maxZoom: 18,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: waterStations
              .map((marker) => Marker(
                    point: marker.position, // Use the existing point property
                    width: 80.0,
                    height: 80.0,
                    child: GestureDetector(
                      onTap: () => navigateToDetailsPage(context, marker),
                      child: marker.child,
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class WaterStationMarker {
  final String name;
  final String description;
  final LatLng position; // Use the existing point property name
  //final String image;
  final String address;
  final int likes;
  final bool isActive;
  final bool isAvailable;
  final Map<String, int> rating;

  static final Widget markerChild = Container(
    child: Container(
      child: Image.asset('assets/image/frontpage.png'),
    ),
    /*const Icon(
      Icons.water_drop,
      size: 40,
      color: Colors.blueAccent,
    ), */

  );

  WaterStationMarker({
    required this.position,
    required this.name,
    this.description = '',
    //required this.image,
    required this.address,
    required this.likes,
    required this.isActive,
    required this.isAvailable,
    required this.rating,
  }) : super();

  Widget get child => markerChild;
}