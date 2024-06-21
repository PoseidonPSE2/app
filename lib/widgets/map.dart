import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hello_worl2/model/refillstation.dart';
import 'package:hello_worl2/pages/WaterstationDetails.dart';
import 'package:hello_worl2/provider/refillstation_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<Map> {
  final provider = RefillStationProvider();

  @override
  void initState() {
    super.initState();
  }

  void navigateToDetailsPage(
      BuildContext context, RefillStationMarker marker) async {
    await provider.fetchStationById(marker.id);
    await provider.fetchReviewAverage(marker.id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Waterstationdetails(
          marker: marker,
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
    return Consumer<RefillStationProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.errorMessage != null) {
          return Center(child: Text('Error: ${provider.errorMessage}'));
        } else if (provider.stations.isEmpty) {
          return const Center(child: Text('Keine Refill-Station vorhanden!'));
        } else {
          final refillStationLocations = provider.stations;
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
                markers: [
                  // Existing markers from refillStationLocations
                  ...refillStationLocations.map((marker) {
                    return Marker(
                      point: LatLng(marker.latitude, marker.longitude),
                      width: 90.0,
                      height: 90.0,
                      child: marker.status
                          ? GestureDetector(
                              onTap: () =>
                                  navigateToDetailsPage(context, marker),
                              child: _buildMarkerChild(marker.status),
                            )
                          : _buildMarkerChild(marker.status),
                    );
                  }).toList(),

/*                  if (currentLocation != null)
                    Marker(
                      point: LatLng(
                        currentLocation!.latitude,
                        currentLocation!.longitude,
                      ),
                      child: const Icon(Icons.location_on),
                    ),

 */
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
