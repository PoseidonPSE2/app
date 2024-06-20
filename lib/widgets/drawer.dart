import 'package:flutter/material.dart';
import 'package:hello_worl2/pages/other/login.dart';
import 'package:hello_worl2/pages/settings/ContributionCommunity.dart';
import 'package:hello_worl2/pages/settings/ContributionKaiserslautern.dart';
import 'package:hello_worl2/pages/settings/consumertest/consumertest_pages.dart';
import 'package:hello_worl2/pages/settings/myBottle.dart';
import 'package:hello_worl2/widgets/custom_list_tile.dart';
import 'package:hello_worl2/widgets/user_progress.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                const Progress(),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Divider(
                    height: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                CustomListTile(
                  text: 'Beitrag in Kaiserslautern',
                  destination: KLContributionScreen(),
                ),
                CustomListTile(
                  text: 'Community Beitrag',
                  destination: CommunityContributionScreen(),
                ),
                const CustomListTile(
                  text: 'Meine Flasche',
                  destination: MyBottle(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 16.0),
            child: Row(
              children: [
                Icon(Icons.logout),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
