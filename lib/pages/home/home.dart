import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hello_worl2/pages/refill/refill.dart';
import 'package:hello_worl2/provider/map_provider.dart';
import 'package:hello_worl2/widgets/drawer.dart';
import 'package:hello_worl2/widgets/map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late MapProvider provider;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = Provider.of<MapProvider>(context, listen: false);
    });
  }

  void getCurrentLocation({bool centerMap = false}) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Location Service Disabled'),
          content: Text('Please enable location services.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Location Permission Denied'),
            content: Text('Please grant location permission.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
        return;
      }
    }
    if (provider.isToggled) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      LatLng currentUserLocation =
          LatLng(position.latitude, position.longitude);

      provider.setPosition(currentUserLocation);

      if (centerMap) {
        provider.centerMap();
        setState(() {});
      }
    }
  }

  void startLocationUpdates() {
    timer =
        Timer.periodic(Duration(seconds: 5), (Timer t) => getCurrentLocation());
  }

  void stopLocationUpdates() {
    timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          const Map(),
          Positioned(
            top: 50,
            left: 25,
            child: FloatingActionButton(
              heroTag: 'uniqueDrawer',
              shape: const CircleBorder(),
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
              child: const Icon(Icons.menu),
            ),
          ),
          Positioned(
            top: 50,
            right: 25,
            child: Column(
              children: [
                Consumer<MapProvider>(
                  builder: (context, provider, child) => FloatingActionButton(
                    heroTag: 'userLocation',
                    shape: const CircleBorder(),
                    onPressed: () {
                      provider.toggle();
                      if (provider.isToggled) {
                        getCurrentLocation(centerMap: true);
                        startLocationUpdates();
                      } else {
                        stopLocationUpdates();
                      }
                    },
                    child: Icon(
                      provider.isToggled
                          ? Icons.explore
                          : Icons.explore_outlined,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'centerMap',
                  shape: const CircleBorder(),
                  onPressed: () {
                    getCurrentLocation(centerMap: true);
                  },
                  child: const FaIcon(FontAwesomeIcons.locationArrow),
                ),
              ],
            ),
          ),
        ],
      ),
      extendBody: true,
      drawer: const CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: SizedBox(
          width: 80,
          height: 80,
          child: FittedBox(
            child: FloatingActionButton(
              heroTag: 'uniqueWater',
              shape: const CircleBorder(),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RefillScreen()));
              },
              child: const FaIcon(
                FontAwesomeIcons.glassWaterDroplet,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
