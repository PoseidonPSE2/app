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
                const CustomListTile(
                  text: 'Mein Progress',
                  destination: MyProgress(input: ["123", "14,95€", "2 kg"]),
                ),
                const CustomListTile(
                  text: 'Beitrag in Kaiserslautern',
                  destination: ContributionKaiserslautern(
                    input: ["14x", "65x"],
                  ),
                ),
                const CustomListTile(
                  text: 'Community Beitrag',
                  destination: ContributionCommunity(
                    input: ["149", "2.000kg", "3%"],
                  ),
                ),
                const CustomListTile(
                  text: 'Verbrauchertest',
                  destination: ContributionCommunity(
                    input: ["149", "2.000kg", "3%"],
                  ),
                ),
                const CustomListTile(
                  text: 'Meine Flasche',
                  destination: ContributionCommunity(
                    input: ["149", "2.000kg", "3%"],
                  ),
                ),
                ListTile(
                  title: Text(
                    'Einstellung',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/");
                  },
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
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
