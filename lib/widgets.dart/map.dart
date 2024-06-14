import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hello_worl2/pages/WaterstationDetails.dart';
import 'package:hello_worl2/restApi/mapper.dart';
import 'package:latlong2/latlong.dart';
import 'package:hello_worl2/restApi/apiService.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapScreen> {
  late Future<List<RefillStationMarker>> futureRefillStationLocations;

  @override
  void initState() {
    super.initState();
    futureRefillStationLocations = fetchWaterStations();
  }

  Future<List<RefillStationMarker>> fetchWaterStations() async {
    return await ApiService().getAllRefillMarker();
  }

  void navigateToDetailsPage(
      BuildContext context, RefillStationMarker marker) async {
    var refillstation = await ApiService().getRefillstationById(marker.id);
    var averageReview =
        await ApiService().getRefillStationReviewAverage(marker.id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Waterstationdetails(
          station: refillstation,
          averageReview: averageReview.average,
        ),
      ),
    );
  }

  Widget _buildMarkerChild(bool status) {
    return Image.asset(status
        ? 'assets/image/frontpage.png'
        : 'assets/image/frontpage_dark.png');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RefillStationMarker>>(
      future: futureRefillStationLocations,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Keine Refill-Station vorhanden!'));
        } else {
          final refillStationLocations = snapshot.data!;
          return FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(49.440067, 7.749126),
              initialZoom: 13,
              minZoom: 10,
              maxZoom: 18,
              interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: refillStationLocations.map((marker) {
                  return Marker(
                    point: LatLng(marker.latitude, marker.longitude),
                    width: 90.0,
                    height: 90.0,
                    child: marker.status
                        ? GestureDetector(
                            onTap: () => navigateToDetailsPage(context, marker),
                            child: _buildMarkerChild(marker.status),
                          )
                        : _buildMarkerChild(marker.status),
                  );
                }).toList(),
              ),
            ],
          );
        }
      },
    );
  }
}
