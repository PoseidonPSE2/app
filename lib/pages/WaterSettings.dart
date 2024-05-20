import 'package:flutter/material.dart';
import 'package:hello_worl2/model/bottle.dart';
import 'package:hello_worl2/widgets.dart/choiceChip.dart';
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
  final List<String> fillVolume = [
    "250ml",
    "500ml",
    "750ml",
    "1 Liter",
    "1.5 Liter"
  ];
  final List<String> waterType = ["Still", "Sprudel"];
  final List<String> waterDegree = ["Kalt", "Warm"];

  String selectedFillVolume = "";
  String selectedWaterType = "";
  String selectedWaterDegree = "";

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
                  "Meine Füllmenge",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              MyChoiceChip(
                choiceItems: fillVolume,
                onSelected: (value) {
                  setState(() {
                    selectedFillVolume = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Meine Wasserpräferenz",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              MyChoiceChip(
                choiceItems: waterType,
                onSelected: (value) {
                  setState(() {
                    selectedWaterType = value;
                  });
                },
              ),
              MyChoiceChip(
                choiceItems: waterDegree,
                onSelected: (value) {
                  setState(() {
                    selectedWaterDegree = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        selectedFillVolume.isNotEmpty &&
                        selectedWaterType.isNotEmpty &&
                        selectedWaterDegree.isNotEmpty) {
                      final newBottle = Bottle(
                        title: _textEditingController.text,
                        fill_volume: selectedFillVolume,
                        water_type: selectedWaterType,
                        water_degree: selectedWaterDegree,
                        tag_hardware_id: '',
                      );
                      context.read<BottleProvider>().addBottle(newBottle);
                      Navigator.pop(context);
                    } else {
                      // Show error message if any field is not filled out
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Bitte füllen Sie alle Felder aus'),
                        ),
                      );
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
