import 'package:flutter/material.dart';
import 'package:refill/model/user.dart';
import 'package:refill/provider/bottle_provider.dart';
import 'package:refill/provider/user_provider.dart';
import 'package:refill/widgets/bottle_tile.dart';
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            await Provider.of<UserProvider>(context, listen: false)
                .fetchUserContribution();
            setState(() {});
            Navigator.pop(context);
          },
        ),
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

                // Sort the bottles by id
                final sortedBottles = bottleProvider.bottles
                  ..sort((a, b) => a.id!.compareTo(b.id!));

                return sortedBottles.isEmpty
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
                        itemCount: sortedBottles.length,
                        itemBuilder: (context, index) {
                          return BottleTile(
                            bottle: sortedBottles[index],
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
