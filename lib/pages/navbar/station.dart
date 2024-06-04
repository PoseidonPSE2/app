import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:conversion/conversion.dart';

String _responseText = '';

class RefillScreen extends StatefulWidget {
  const RefillScreen({super.key});

  @override
  _RefillScreenState createState() => _RefillScreenState();
}

class _RefillScreenState extends State<RefillScreen> {
  String _text = '';
  final ValueNotifier<String> _nfcResult = ValueNotifier(''); // Updated type
  double _waterAmount = 0.0;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    // Listen for changes in the ValueNotifier
    _nfcResult.addListener(() {
      setState(() {
        _text = _nfcResult.value;
      });
    });
    _startNFCReading();
  }

  @override
  void dispose() {
    _nfcResult.dispose();
    super.dispose();
  }

  void _showWaterInputDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user can tap outside to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bitte halte den NFC-Tag an dein Handy'),
          content: const TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
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
      key: navigatorKey,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                'Auffüllstation in der Nähe',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
                ),
              ),
            ),
            SizedBox(height: 50.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                "Bitte halte dein Smartphone an das NFC Lesegerät der Refill-Station.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
            SizedBox(height: 40.0),

          ],
        ),
      ),
    );
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
              final hexEncoder = HexEncoder();
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
