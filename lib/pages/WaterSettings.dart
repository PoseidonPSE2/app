import 'package:flutter/material.dart';
import 'package:hello_worl2/model/bottle.dart';
import 'package:hello_worl2/provider/userProvider.dart';
import 'package:hello_worl2/service/new_bottle_service.dart';
import 'package:provider/provider.dart';
import 'package:hello_worl2/provider/bottleProvider.dart';

class WaterSettings extends StatefulWidget {
  const WaterSettings({super.key});

  @override
  State<WaterSettings> createState() => _WaterSettingsState();
}

class _WaterSettingsState extends State<WaterSettings> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  double _currentWaterAmount = 250;
  bool isStillWater = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Refill'),
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
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "Meine Flasche",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
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
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    hintText: 'Flaschentitel',
                  ),
                ),
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
                padding: const EdgeInsets.all(8.0),
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
                          nfcId:
                              "${_textEditingController.text}test", // Falls verfügbar, sonst leer.
                          userId: currentUser.userId,
                        );

                        //context.read<BottleProvider>().addBottle(newBottle);
                        try {
                          Provider.of<BottleProvider>(context, listen: false)
                              .addBottle(newBottle);
                          Provider.of<BottleProvider>(context, listen: false)
                              .fetchBottles(currentUser!);
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
                  child: Text(
                    'Bestätigen',
                    style: Theme.of(context).textTheme.bodyLarge,
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
