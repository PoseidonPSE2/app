import 'package:flutter/material.dart';
import 'package:hello_worl2/model/user.dart';
import 'package:hello_worl2/provider/bottleProvider.dart';
import 'package:hello_worl2/provider/userProvider.dart';
import 'package:hello_worl2/widgets.dart/bottleTile.dart';
import 'package:provider/provider.dart';

class MyBottle extends StatefulWidget {
  const MyBottle({super.key});

  @override
  State<MyBottle> createState() => _MyBottleState();
}

class _MyBottleState extends State<MyBottle> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = Provider.of<UserProvider>(context, listen: false).user;
    if (currentUser != null) {
      Provider.of<BottleProvider>(context, listen: false)
          .fetchBottles(currentUser!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Meine Flaschen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<BottleProvider>(
              builder: (context, bottleProvider, child) {
                if (bottleProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return bottleProvider.bottles.isEmpty
                    ? Center(
                        child: Text(
                          "Erstelle neue Wasserflaschen...",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: bottleProvider.bottles.length,
                        itemBuilder: (context, index) {
                          return BottleTile(
                            bottle: bottleProvider.bottles[index],
                          );
                        },
                      );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/water_settings");
              },
              child: Text(
                'Erstelle eine neue Wasserflasche',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(30),
          ),
        ],
      ),
    );
  }
}
