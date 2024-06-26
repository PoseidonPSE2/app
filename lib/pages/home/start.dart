import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NfcAidPage(),
    );
  }
}

class NfcAidPage extends StatefulWidget {
  @override
  _NfcAidPageState createState() => _NfcAidPageState();
}

class _NfcAidPageState extends State<NfcAidPage> {
  String _aid = "NFC AID will be displayed here";

  @override
  void initState() {
    super.initState();
    _getNfcAid();
  }

  Future<void> _getNfcAid() async {
    // Diese Methode wird die AID lesen, wenn NFC aktiviert ist.
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (isAvailable) {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        var aid = tag.data[
            'techList']; // Beispielweise wie die AID extrahiert werden könnte
        setState(() {
          _aid = aid.toString();
        });
        NfcManager.instance.stopSession();
      });
    } else {
      setState(() {
        _aid = "NFC is not available on this device";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NFC AID Viewer"),
      ),
      body: Center(
        child: Text(_aid),
      ),
    );
  }
}
