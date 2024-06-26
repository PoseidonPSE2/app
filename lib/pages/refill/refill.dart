import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hello_worl2/model/bottle.dart';
import 'package:hello_worl2/model/user.dart';
import 'package:hello_worl2/pages/refill/refill_settings.dart';
import 'package:hello_worl2/provider/bottle_provider.dart';
import 'package:hello_worl2/provider/user_provider.dart';
import 'package:provider/provider.dart';

class RefillScreen extends StatefulWidget {
  const RefillScreen({super.key});

  @override
  _RefillScreenState createState() => _RefillScreenState();
}

class _RefillScreenState extends State<RefillScreen> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  User? currentUser;
  String nfcId = "04:72:52:1A:94:11:90";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentUser = Provider.of<UserProvider>(context, listen: false).user;
      if (currentUser != null) {
        Provider.of<BottleProvider>(context, listen: false)
            .fetchBottles(currentUser!);
        Provider.of<UserProvider>(context, listen: false)
            .fetchUserContribution();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flasche auffüllen"),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      key: navigatorKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 80,
            ),
            Expanded(
              child: Consumer<BottleProvider>(
                builder: (context, bottleProvider, child) {
                  if (bottleProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (bottleProvider.bottles.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Manuell auffüllen"),
                        ),
                        const SizedBox(height: 40.0),
                      ],
                    );
                  }
                  final sortedBottles = bottleProvider.bottles
                    ..sort((a, b) => a.id!.compareTo(b.id!));

                  return Column(
                    children: [
                      Center(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.4,
                            enableInfiniteScroll: false,
                          ),
                          items: sortedBottles.map((bottle) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () async {
                                    Bottle editedBottle = Bottle(
                                      id: 1,
                                      title: "Letzte App-Wahl",
                                      fillVolume: bottle.fillVolume.toInt(),
                                      waterType: bottle.waterType,
                                      nfcId: nfcId.toUpperCase(),
                                      userId: bottle.userId,
                                    );
                                    try {
                                      await Provider.of<BottleProvider>(context,
                                              listen: false)
                                          .editBottle(editedBottle);
                                      await Provider.of<BottleProvider>(context,
                                              listen: false)
                                          .fetchBottles(currentUser!);
                                      setState(() {});
                                    } catch (e) {
                                      print('Error creating new bottle: $e');
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                      image: DecorationImage(
                                        image:
                                            _getImageProvider(bottle.pathImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: const BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight:
                                                  Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  bottle.title,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      bottle.waterType == "tap"
                                                          ? "Still"
                                                          : "Sprudel",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${bottle.fillVolume} ml",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Text("oder"),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditRefill(
                                  bottle: Bottle(
                                      userId: 4,
                                      id: 1,
                                      fillVolume: 250,
                                      waterType: "tap",
                                      title: "Letzte App-Wahl"))));
                        },
                        child: const Text("Manuell auffüllen"),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider<Object> _getImageProvider(String? pathImage) {
    if (pathImage == null || pathImage.isEmpty) {
      return const AssetImage("assets/image/wasserspender.jpg");
    } else {
      // Handle Base64 encoded image
      final base64Data = pathImage;
      return MemoryImage(base64Decode(base64Data));
    }
  }
}
