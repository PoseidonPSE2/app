import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'navbar/map.dart';

class Waterstationreport extends StatelessWidget {
  const Waterstationreport({super.key});

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
                    //controller: _textEditingController,

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
                    //controller: _textEditingController,
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
                    onPressed: () {},
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
