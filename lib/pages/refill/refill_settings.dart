import 'package:flutter/material.dart';
import 'package:hello_worl2/model/bottle.dart';
import 'package:hello_worl2/provider/user_provider.dart';
import 'package:hello_worl2/widgets/loading_animation.dart';
import 'package:provider/provider.dart';
import 'package:hello_worl2/provider/bottle_provider.dart';

class EditRefill extends StatefulWidget {
  final Bottle bottle;

  const EditRefill({super.key, required this.bottle});

  @override
  State<EditRefill> createState() => _EditBottleState();
}

class _EditBottleState extends State<EditRefill> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late double _currentWaterAmount;
  late bool isStillWater;
  bool _isLoading = false;
  String nfcId = "04:72:52:1A:94:11:90";

  @override
  void initState() {
    super.initState();
    _currentWaterAmount = widget.bottle.fillVolume.toDouble();
    isStillWater = widget.bottle.waterType == "tap";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Wasserpräferenz'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _onConfirm,
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            )
                          : const Text(
                              'Bestätigen',
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onConfirm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final userProvider = context.read<UserProvider>();
      final currentUser = userProvider.user; // Access the current user
      if (currentUser != null) {
        Bottle editedBottle = Bottle(
          id: 1,
          title: "Letzte App-Wahl",
          fillVolume: _currentWaterAmount.toInt(),
          waterType: isStillWater ? "tap" : "mineral",
          nfcId: nfcId.toUpperCase(),
          userId: currentUser.userId,
          pathImage: widget.bottle.pathImage,
          active: widget.bottle.active,
          waterTransactions: widget.bottle.waterTransactions,
        );

        try {
          await Provider.of<BottleProvider>(context, listen: false)
              .editBottle(editedBottle);
          await Provider.of<BottleProvider>(context, listen: false)
              .fetchBottles(currentUser);
        } catch (e) {
          print('Error creating new bottle: $e');
        }

        setState(() {
          _isLoading = false;
        });

        // Popup anzeigen
        _showNfcScanDialog(5.0); // Provide the duration in seconds
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showNfcScanDialog(double duration) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('NFC Scan erforderlich'),
          content: const Text(
              'Gehe jetzt zur Wasserstation um dein NFC zu scannen.'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFF2196F3),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _showWaterAnimationDialog(duration);
              },
            ),
          ],
        );
      },
    );
  }

  void _showWaterAnimationDialog(double duration) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: WaterloadingAnimation(duration: duration),
          ),
        );
      },
    );
  }
}
