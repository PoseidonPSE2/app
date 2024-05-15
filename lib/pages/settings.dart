import 'package:flutter/material.dart';
import 'package:hello_worl2/pages/ContributionCommunity.dart';
import 'package:hello_worl2/pages/ContributionKaiserslautern.dart';
import 'package:hello_worl2/pages/myProgress.dart';
import 'package:hello_worl2/widgets.dart/customListTile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
          Expanded(
            child: ListView(
              children: [
                CustomListTile(
                  text: 'Mein Progress',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MyProgress(
                          input: ["123", "14,95€", "2 kg"],
                        ),
                      ),
                    );
                  },
                ),
                CustomListTile(
                  text: 'Beitrag in Kaiserslautern',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ContributionKaiserslautern(
                          input: ["14x", "65x"],
                        ),
                      ),
                    );
                  },
                ),
                CustomListTile(
                  text: 'Community Beitrag',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ContributionCommunity(
                          input: ["149", "2.000kg", "3%"],
                        ),
                      ),
                    );
                  },
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
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/");
                  },
                ),
              ],
            ),
          ),
          Text(
            "App Versions",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            "v0.0.2",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 30))
        ],
      ),
    );
  }
}
