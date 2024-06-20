import 'package:flutter/material.dart';
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: SizedBox(
          width: 80,
          height: 80,
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
    );
  }
}
