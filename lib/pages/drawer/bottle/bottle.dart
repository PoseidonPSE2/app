import 'package:flutter/material.dart';
import 'package:hello_worl2/model/user.dart';
import 'package:hello_worl2/provider/bottle_provider.dart';
import 'package:hello_worl2/provider/user_provider.dart';
import 'package:hello_worl2/widgets/bottle_tile.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentUser = Provider.of<UserProvider>(context, listen: false).user;
      if (currentUser != null) {
        Provider.of<BottleProvider>(context, listen: false)
            .fetchBottles(currentUser!);
      }
    });
  }

  Future<void> _refreshBottles() async {
    if (currentUser != null) {
      await Provider.of<BottleProvider>(context, listen: false)
          .fetchBottles(currentUser!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Meine Flaschen'),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.pushNamed(context, "/water_settings");
              _refreshBottles();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<BottleProvider>(
              builder: (context, bottleProvider, child) {
                if (bottleProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
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
        ],
      ),
    );
  }
}