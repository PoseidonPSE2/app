import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nfc_manager/nfc_manager.dart';


String _responseText = '';

void _makeAPICall_post(String text) async {
  print("go");

  Map<String, dynamic> data = {
    'water': 600, // Example value, replace with your actual data
    'user_id': 1, // Example value, replace with your actual data
    'water_type': text // Example value, replace with your actual data
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

  print("wait for answer");
  if (response.statusCode ==200) {
    // Handle successful API call
    _responseText = response.body;
  } else {
    // Handle error
    _responseText = 'Failed to make API call';
  }
  print(_responseText);
}

class RefillScreen extends StatelessWidget {
  String _text = '';
  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 52, 76, 1),
      // Set the background color to blue
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                'Auffüllstation in der Nähe',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                ), // Adjust font size as needed
              ),
            ),
            SizedBox(height: 50.0), // Add spacing between elements
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                "Bitte halte dein Smartphone an das NDFC Lesegerät der Refill-Station.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
            SizedBox(height: 30.0), // Add spacing between elements
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                "Falls die Refill-Station über keinen NFC-Reader verfügt, drücke bitte unten auf den Button.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
            SizedBox(height: 40.0), // Add spacing between elements
            ElevatedButton(
              onPressed: _startNFCReading,
              child: Text(
                'Manuell auffüllen',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                // Set the background color to blue
              ),
            ),
            SizedBox(height: 20.0), // Add spacing between elements
            SizedBox(height: 50.0), // Add spacing between elements
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                'NFC Token: ${_text}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
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
          var nfcData = tag.data as Map<String, dynamic>;

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
                _makeAPICall_post(text);
              }
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



