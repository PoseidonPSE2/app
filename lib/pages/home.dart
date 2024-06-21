import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hello_worl2/pages/navbar/refill.dart';
import 'package:hello_worl2/widgets/bottom_sheet.dart';
import 'package:hello_worl2/widgets/drawer.dart';
import 'package:hello_worl2/widgets/map.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Entfernt: Der Aufruf von fetchStations ist nicht mehr hier notwendig
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
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    /*
    setState(() {

      currentLocation = LocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      mapController.move(
        LatLng(currentLocation!.latitude, currentLocation!.longitude),
        15.0,
      );
    });

     */
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
          const CustomBottomSheet(),
        ],
      ),
      extendBody: true,
      drawer: const CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Column(
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
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: 60,
              height: 60,
              child: FittedBox(
                child: FloatingActionButton(
                  heroTag: 'userLocation',
                  shape: const CircleBorder(),
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => const RefillScreen()));
                  },
                  child: const Icon(Icons.explore_outlined),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
