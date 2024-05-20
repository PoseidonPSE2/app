import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nfc_manager/nfc_manager.dart';


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

  Future<void> _showWaterInputDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user can tap outside to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Wassermenge eingeben'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "z.B. 1.5",
            ),
            onChanged: (value) =>
                setState(() => _waterAmount = double.parse(value)),
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
                String water = _waterAmount.toString();
                _makeAPICall_post(_text, water);
              },
            ),
          ],
        );
      },
    );
  }

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
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 50.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                "Bitte halte dein Smartphone an das NFC Lesegerät der Refill-Station.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, color: Colors.white),
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

            if (cachedMessageMap.containsKey('cachedMessage')) {
              var records = cachedMessageMap['cachedMessage'];

              var payload = records['records'];

              for (var entry in payload) {
                var payloadBytes = entry['payload'];
                String text = utf8.decode(payloadBytes);
                text = text.substring(3);
                _text = text;
              }
            }
          }
          _showWaterInputDialog();
        });
      } else {
        print('NFC not available.');
      }
    } catch (e) {
      print('Error reading NFC: $e');
    }
  }

  void _makeAPICall_post(String stationsName, String waterAmount) async {
    print("go");

    Map<String, dynamic> data = {
      'water': waterAmount, // Example value, replace with your actual data
      'user_id': 1, // Example value, replace with your actual data
      'water_type': stationsName // Example value, replace with your actual data
    };

    print("create json body");
    // Encode the data to JSON
    var body = json.encode(data);

    print("send request");
    // Make POST request
    final response = await http.post(
      Uri.parse('https://2sc10r.buildship.run/create_entry'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    print(body);

    print("wait for answer");
    if (response.statusCode == 200) {
      // Handle successful API call
      _responseText = response.body;
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text('Erfolgreich! Daten an API gesendet.'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Handle error
      _responseText = 'Failed to make API call';
    }
    print(_responseText);
  }
}
