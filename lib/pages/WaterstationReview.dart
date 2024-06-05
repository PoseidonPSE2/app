import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_worl2/restApi/apiService.dart';
import 'package:hello_worl2/restApi/mapper.dart';
import 'package:hex/hex.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';
import '../provider/userProvider.dart';
import '../widgets.dart/reviewSlider.dart';
import 'navbar/map.dart';

class Waterstationreview extends StatefulWidget {
  final RefillStation station;

  const Waterstationreview({super.key, required this.station});

  @override
  State<Waterstationreview> createState() => _WaterstationreviewState();
}

class _WaterstationreviewState extends State<Waterstationreview> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = Provider.of<UserProvider>(context, listen: false).user;
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
                  hexStringWithOperator += "${hexString[i]}:";
                }
              }

              String nfcChipId = hexStringWithOperator.substring(
                  0, hexStringWithOperator.length - 1);
              print(nfcChipId);
            }
          }
          NfcManager.instance.stopSession();
        });
      } else {
        print('NFC not available.');
      }
    } catch (e) {
      print('Error reading NFC: $e');
    }
  }

  AlertDialog nfcDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Möchten Sie den NFC-Chip scannen?'),
      content: Text(''),
      actions: [
        TextButton(
          child: Text('Abbrechen'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text('Scannen'),
          onPressed: () {
            Navigator.pop(context); // Schließe den Dialog
            _startNFCReading(); // Starte die NFC-Lesefunktion
          },
        ),
      ],
    );
  }

  void _showNFCDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => nfcDialog(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wasserstation Details'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sauberkeit',
                    style: Theme.of(context).textTheme.labelLarge),
                const Reviewslider(initialValue: 3.5),
                Text('Barrierefreiheit',
                    style: Theme.of(context).textTheme.labelLarge),
                const Reviewslider(initialValue: 3.5),
                Text('Wasserqualität',
                    style: Theme.of(context).textTheme.labelLarge),
                const Reviewslider(initialValue: 3.5),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      RefillstationReview review = RefillstationReview(
                          cleanness: 3,
                          accessibility: 3,
                          water_quality: 3,
                          station_id: widget.station.id,
                          user_id: currentUser?.userId);
                      ApiService().postRefillstationReview(review);
                    },
                    child: Text(
                      'Absenden',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),

                /*  ElevatedButton(
              onPressed: () => _showNFCDialog(context),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
              ),
              child: Icon(
                Icons.nfc,
                size: 32,
                color: Colors.white,
              ),
            ),
           */
              ]),
        ));
  }
}
