import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hello_worl2/model/refillstation.dart';
import 'package:hello_worl2/model/user.dart';
import 'package:hello_worl2/pages/map/WaterstationDetails.dart';
import 'package:hello_worl2/provider/refillstation_provider.dart';
import 'package:hello_worl2/provider/user_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../provider/map_provider.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<Map> {
  late MapProvider mapProvider;
  late RefillStationProvider provider;
  User? currentUser;
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    currentUser = Provider.of<UserProvider>(context, listen: false).user;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = Provider.of<RefillStationProvider>(context, listen: false);
      mapProvider = Provider.of<MapProvider>(context, listen: false);
    });
  }

  void navigateToDetailsPage(
      BuildContext context, RefillStationMarker marker) async {
    await provider.fetchStationById(marker.id);
    await provider.fetchReviewAverage(marker.id);
    await provider.getLike(marker.id, currentUser!.userId);
    await provider.getLikeCounterForStation(marker.id);
    await provider.fetchImage(marker.id);
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

  void _centerOnLocation(LatLng location) {
    mapController.move(location, mapController.camera.zoom);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<RefillStationProvider, MapProvider>(
      builder: (context, provider, mapProvider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.errorMessage != null) {
          return Center(child: Text('Error: ${provider.errorMessage}'));
        } else if (provider.stationMarkers.isEmpty) {
          return const Center(child: Text('Keine Refill-Station vorhanden!'));
        } else {
          final refillStationLocations = provider.stationMarkers;

          if (mapProvider.shouldCenterMap) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _centerOnLocation(mapProvider.getUserLocation);
            });
          }

          return FlutterMap(
            mapController: mapController,
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
                  }),
                  if (mapProvider.isToggled)
                    Marker(
                      point: mapProvider.getUserLocation,
                      width: 90.0,
                      height: 90.0,
                      child: const Icon(
                        Icons.location_on,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
