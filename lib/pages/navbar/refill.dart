import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hello_worl2/model/user.dart';
import 'package:hello_worl2/provider/bottle_provider.dart';
import 'package:hello_worl2/provider/user_provider.dart';
import 'package:hex/hex.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';

class RefillScreen extends StatefulWidget {
  const RefillScreen({super.key});

  @override
  _RefillScreenState createState() => _RefillScreenState();
}

class _RefillScreenState extends State<RefillScreen> {
  String _text = '';
  final ValueNotifier<String> _nfcResult = ValueNotifier('');
  double _waterAmount = 0.0;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _nfcResult.addListener(() {
      setState(() {
        _text = _nfcResult.value;
      });
    });
    _startNFCReading();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentUser = Provider.of<UserProvider>(context, listen: false).user;
      if (currentUser != null) {
        Provider.of<BottleProvider>(context, listen: false)
            .fetchBottles(currentUser!);
      }
    });
  }

  @override
  void dispose() {
    _nfcResult.dispose();
    super.dispose();
  }

  void _showWaterInputDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bitte halte den NFC-Tag an dein Handy'),
          content: const TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "z.B. 1.5",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Abbrechen'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Bestätigen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Bitte halte dein Smartphone an das NFC Lesegerät der Refill-Station.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            Consumer<BottleProvider>(
              builder: (context, bottleProvider, child) {
                if (bottleProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return bottleProvider.bottles.isEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Manuell auffüllen"),
                          ),
                          const SizedBox(height: 40.0),
                        ],
                      )
                    : Column(
                        children: [
                          Center(
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                enableInfiniteScroll: false,
                              ),
                              items: bottleProvider.bottles.map((bottle) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return GestureDetector(
                                      onTap: () {
                                        print("hi");
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 10,
                                              offset: Offset(0, 5),
                                            ),
                                          ],
                                          image: DecorationImage(
                                            image: _getImageProvider(
                                                bottle.pathImage),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              decoration: const BoxDecoration(
                                                color: Colors.black54,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10.0),
                                                  bottomRight:
                                                      Radius.circular(10.0),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      bottle.title,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                          bottle.waterType,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${bottle.fillVolume} ml",
                                                          style:
                                                              const TextStyle(
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
                            onPressed: () {},
                            child: const Text("Manuell auffüllen"),
                          ),
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider<Object> _getImageProvider(String? pathImage) {
    if (pathImage == null || pathImage.isEmpty) {
      return AssetImage("assets/image/wasserspender.jpg");
    } else {
      // Handle Base64 encoded image
      final base64Data = pathImage;
      return MemoryImage(base64Decode(base64Data));
    }
  }

  void _startNFCReading() async {
    try {
      bool isAvailable = await NfcManager.instance.isAvailable();
      if (isAvailable) {
        NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
          var nfcData = tag.data;

          Map<String, dynamic> ndefMap = nfcData;

          if (ndefMap.containsKey('ndef')) {
            var cachedMessageMap = ndefMap['ndef'];
            if (cachedMessageMap.containsKey('identifier')) {
              var identifier = cachedMessageMap['identifier'];
              final hexEncoder = const HexEncoder();
              String hexString = hexEncoder.convert(identifier);
              String hexStringWithOperator = "";

              for (int i = 0; i < hexString.length; i++) {
                if (i % 2 == 0) {
                  hexStringWithOperator += hexString[i];
                } else {
                  hexStringWithOperator += hexString[i] + ":";
                }
              }

              String nfcChipId = hexStringWithOperator.substring(
                  0, hexStringWithOperator.length - 1);
              _nfcResult.value = nfcChipId;
            }
          }
        });
      } else {
        print('NFC not available.');
      }
    } catch (e) {
      print('Error reading NFC: $e');
    }
  }
}
