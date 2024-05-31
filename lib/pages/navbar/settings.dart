import 'package:flutter/material.dart';
import 'package:hello_worl2/pages/settings/ContributionCommunity.dart';
import 'package:hello_worl2/pages/settings/ContributionKaiserslautern.dart';
import 'package:hello_worl2/pages/settings/myBottle.dart';
import 'package:hello_worl2/pages/settings/myProgress.dart';
import 'package:hello_worl2/provider/userProvider.dart';
import 'package:hello_worl2/widgets.dart/customListTile.dart';
import 'package:hello_worl2/widgets.dart/testingWidget.dart';
import 'package:hello_worl2/widgets.dart/waterLoadingAnimation.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
          Expanded(
            child: ListView(
              children: [
                const CustomListTile(
                  text: 'Mein Progress',
                  destination: MyProgress(),
                ),
                CustomListTile(
                  text: 'Beitrag in Kaiserslautern',
                  destination: KLContributionScreen(),
                ),
                CustomListTile(
                  text: 'Community Beitrag',
                  destination: CommunityContributionScreen(),
                ),
                CustomListTile(
                  text: 'Verbrauchertest',
                  destination: WaterloadingAnimation(),
                ),
                const CustomListTile(
                  text: 'Meine Flasche',
                  destination: MyBottle(),
                ),
                ListTile(
                  title: Text(
                    'Einstellung',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/test");
                  },
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
