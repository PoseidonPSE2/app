import 'package:flutter/material.dart';
import 'package:hello_worl2/ui/widgets.dart/customListTile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<SettingsScreen> {
  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1c3845),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
          Expanded(
            child: ListView(
              children: [
                CustomListTile(
                  text: 'Mein Progress',
                  onTap: () {},
                ),
                CustomListTile(
                  text: 'Beitrag in Kaiserslautern',
                  onTap: () {},
                ),
                CustomListTile(
                  text: 'Community Beitrag',
                  onTap: () {},
                ),
                CustomListTile(
                  text: 'Verbrauchertest',
                  onTap: () {},
                ),
                CustomListTile(
                  text: 'Meine Flasche',
                  onTap: () {},
                ),
                CustomListTile(
                  text: 'Einstellung',
                  onTap: () {},
                ),
              ],
            ),
          ),
          const Text(
            "App Versions",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 21, fontWeight: FontWeight.w500),
          ),
          const Text(
            "v0.0.1",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromARGB(255, 102, 152, 226),
                fontSize: 14,
                fontWeight: FontWeight.w300),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 30))
        ],
      ),
    );
  }
}
