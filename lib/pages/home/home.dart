import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hello_worl2/pages/home/refill.dart';
import 'package:hello_worl2/provider/map_provider.dart';
import 'package:hello_worl2/widgets/bottom_sheet.dart';
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
  List<LatLng> locationslol = [
    LatLng(49.4433, 7.7622),
    LatLng(49.440067, 7.749126),
    LatLng(49.44694255672088, 7.751210803377673)
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = Provider.of<MapProvider>(context, listen: false);
    });
  }

  void getCurrentLocation() async {
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

      provider.setPosition(locationslol.removeLast());

      setState(() {});
    }
  }

  void startLocationUpdates() {
    timer = Timer.periodic(
        Duration(seconds: 30), (Timer t) => getCurrentLocation());
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
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 50),
            child: FloatingActionButton(
              heroTag: 'uniqueDrawer',
              shape: const CircleBorder(),
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
              child: const Icon(Icons.menu),
            ),
          ),
          //const CustomBottomSheet(),
        ],
      ),
      extendBody: true,
      drawer: const CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min, // Restrict column size
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: 60,
              height: 60,
              child: FittedBox(
                child: FloatingActionButton(
                  heroTag: 'uniqueNFC',
                  shape: const CircleBorder(),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RefillScreen()));
                  },
                  child: const Icon(Icons.nfc),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: SizedBox(
              width: 60,
              height: 60,
              child: FittedBox(
                child: Consumer<MapProvider>(
                  builder: (context, provider, child) => FloatingActionButton(
                    heroTag: 'userLocation',
                    shape: const CircleBorder(),
                    onPressed: () {
                      provider.toggle();
                      if (provider.isToggled) {
                        getCurrentLocation();
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
