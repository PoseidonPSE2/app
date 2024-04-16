import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String _responseText = '';

void _makeAPICall_post() async {
  print("go");

  Map<String, dynamic> data = {
    'water': 600, // Example value, replace with your actual data
    'user_id': 1, // Example value, replace with your actual data
    'water_type': 'sprudlig' // Example value, replace with your actual data
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
  if (response.statusCode == 200) {
    // Handle successful API call
    _responseText = response.body;
  } else {
    // Handle error
    _responseText = 'Failed to make API call';
  }
  print(_responseText);
}

class RefillScreen extends StatelessWidget {
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
              onPressed: _makeAPICall_post,
              child: Text(
                'Manuell auffüllen',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                // Set the background color to blue
              ),
            ),
          ],
        ),
      ),
    );
  }
}
