import 'package:flutter/material.dart';
import 'package:refill/pages/home/login.dart';
import 'package:refill/pages/drawer/contribution_community.dart';
import 'package:refill/pages/drawer/bottle/bottle.dart';
import 'package:refill/widgets/custom_list_tile.dart';
import 'package:refill/widgets/user_progress.dart';

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
                const CustomListTile(
                  text: 'Beitrag der Community',
                  destination: CommunityContributionScreen(),
                ),
                const CustomListTile(
                  text: 'Meine Flaschen',
                  destination: MyBottle(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 16.0),
            child: Row(
              children: [
                const Icon(Icons.logout),
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
