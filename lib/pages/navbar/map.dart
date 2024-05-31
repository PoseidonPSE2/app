import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hello_worl2/pages/WaterstationDetails.dart';
import 'package:hello_worl2/restApi/mapper.dart';
import 'package:hello_worl2/restApi/waterEnums.dart';
import 'package:latlong2/latlong.dart';

import 'package:hello_worl2/restApi/apiService.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapScreen> {
  List<RefillStation> waterStations = [];
  List<RefillStationMarker> refillStationLocations = [];

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
        "id": 1,
        "name": "Wasserstation Kaiserslautern",
        "description": "Öffentliche Trinkwasserstation",
        "latitude": 49.440067,
        "longitude": 7.749126,
        "image": "", // Add an image field to your data
        "address": "Jacobstarße 15, 67655 Kaiserslautern",
        "likeCounter": 3,
        "active": true,
        "openingTimes": "xxxx",
        "type": "smart",
        "offeredWatertype": "mineral",
        "waterSource": "Quellwasaser"
      },
      {
        "id": 2,
        "name": "Wasserstation Lauterstraße",
        "description": "Öffentliche Trinkwasserstation",
        "latitude": 49.447687,
        "longitude": 7.760024,
        "image": "", // Add an image field to your data
        "address": "Lauferstraße 12, 67655 Kaiserslautern",
        "likeCounter": 1,
        "active": true,
        "openingTimes": "xxxx",
        "type": "smart",
        "offeredWatertype": "mineral",
        "waterSource": "Quellwasaser"
      },
    ];
    final markers = await ApiService().getAllRefillMarker();

    setState(() {
      waterStations = dummyData
          .map((station) => RefillStation(
                id: station["id"] as int,
                name: station["name"] as String,
                description: station["description"] as String,
                latitude: station["latitude"] as double,
                longitude: station["longitude"] as double,
                address: station["address"] as String,
                likeCounter: station["likeCounter"] as int,
                waterSource: station["waterSource"] as String,
                openingTimes: station["openingTimes"] as String,
                active: station["active"] as bool,
                type: getWaterStationType(station["type"] as String),
                offeredWatertype:
                    getOfferedWatertype(station["offeredWatertype"] as String),
              ))
          .toList();

      refillStationLocations = markers;
    });
  }

  void navigateToDetailsPage(BuildContext context, RefillStationMarker marker) async{
    var refillstation = await ApiService().getRefillstationById(marker.id);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Waterstationdetails(station: refillstation),
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
          markers: refillStationLocations
              .map((marker) => Marker(
                    point: LatLng(marker.latitude, marker.longitude),
                    // Use the existing point property
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
