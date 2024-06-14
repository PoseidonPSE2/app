import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_worl2/restApi/apiService.dart';
import 'package:hello_worl2/restApi/mapper.dart';
import '../widgets.dart/map.dart';

class Waterstationreport extends StatefulWidget {
  final RefillStation station;

  const Waterstationreport({super.key, required this.station});

  @override
  State<Waterstationreport> createState() => _WaterWaterstationreportState();
}

class _WaterWaterstationreportState extends State<Waterstationreport> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitte geben Sie dem Problem einen Titel';
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
                      hintText: 'Problemtitel',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    maxLines: 10,
                    controller: _descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitte beschreibe das Problem';
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
                      hintText: 'Problembeschreibung',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      RefillstationProblem problem = RefillstationProblem(
                          station_id: widget.station.id,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          status: "Active");
                      ApiService().postRefillstationProblem(problem);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Absenden',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ]),
        ));
  }
}
