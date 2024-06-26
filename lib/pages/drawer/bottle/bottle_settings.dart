import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hello_worl2/model/bottle.dart';
import 'package:hello_worl2/provider/user_provider.dart';
import 'package:hex/hex.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';
import 'package:hello_worl2/provider/bottle_provider.dart';

class WaterSettings extends StatefulWidget {
  const WaterSettings({super.key});

  @override
  State<WaterSettings> createState() => _WaterSettingsState();
}

class _WaterSettingsState extends State<WaterSettings> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  double _currentWaterAmount = 250;
  bool isStillWater = true;
  String nfcId = "";
  File? _selectedImage;
  String? _base64Image;

  @override
  void initState() {
    super.initState();
    _startNFCReading();
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
                  hexStringWithOperator += "${hexString[i]}:";
                }
              }

              String nfcChipId = hexStringWithOperator.substring(
                  0, hexStringWithOperator.length - 1);
              print(nfcChipId);
              setState(() {
                nfcId = nfcChipId;
              });
            }
          }
        });
      } else {
        print('NFC ist nicht erreichbar.');
      }
    } catch (e) {
      print('Error beim NFC lesen: $e');
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        setState(() {
          _selectedImage = imageFile;
        });
        await _convertImageToBase64(imageFile);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _convertImageToBase64(File image) async {
    try {
      final bytes = await image.readAsBytes();
      setState(() {
        _base64Image = base64Encode(bytes);
      });
    } catch (e) {
      print('Error converting image to Base64: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Neue Flasche'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: _textEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bitte geben Sie einen Flaschentitel ein';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    hintText: 'Flaschentitel',
                  ),
                ),
              ),
              if (_selectedImage != null)
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.file(
                    _selectedImage!,
                    width: 100,
                    height: 100,
                  ),
                ),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Bild auswählen'),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Meine Wasserpräferenz",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Slider(
                value: _currentWaterAmount,
                min: 250,
                max: 1500,
                divisions: 5,
                label: '${_currentWaterAmount.round()} ml',
                onChanged: (double value) {
                  setState(() {
                    _currentWaterAmount = value;
                  });
                },
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('250 ml', style: TextStyle(fontSize: 16)),
                  Text('1500 ml', style: TextStyle(fontSize: 16)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Still',
                      style: TextStyle(fontSize: 16),
                    ),
                    Switch(
                      value: !isStillWater,
                      onChanged: (bool value) {
                        setState(() {
                          isStillWater = !value;
                        });
                      },
                    ),
                    const Text(
                      'Sprudel',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              nfcId == ""
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Bitte NFC-Chip scannen:",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "(optional NFC auf dem Smartphone aktivieren)",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(nfcId.toUpperCase()),
                          const Icon(
                            Icons.check,
                            size: 50,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final userProvider = context.read<UserProvider>();
                      final currentUser =
                          userProvider.user; // Access the current user
                      if (currentUser != null) {
                        // Check if currentUser is not null
                        final newBottle = Bottle(
                          title: _textEditingController.text,
                          fillVolume: _currentWaterAmount.toInt(),
                          waterType: isStillWater ? "tap" : "mineral",
                          nfcId: nfcId
                              .toUpperCase(), // Falls verfügbar, sonst leer.
                          userId: currentUser.userId,
                          pathImage: _base64Image,
                        );

                        try {
                          await Provider.of<BottleProvider>(context,
                                  listen: false)
                              .addBottle(newBottle);
                        } catch (e) {
                          print('Error creating new bottle: $e');
                        }
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Bitte füllen Sie alle Felder aus'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Bestätigen',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
