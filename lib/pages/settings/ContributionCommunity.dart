import 'package:flutter/material.dart';

class ContributionCommunity extends StatelessWidget {
  final List<String> input;
  const ContributionCommunity({super.key, required this.input});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Refill',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Image(image: AssetImage("assets/recycling.jpg")),
          const Padding(padding: EdgeInsets.all(10)),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              "Du bist einer von ${input[0]} aktiven Refillern!",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              'Gemeinsam habt ihr ${input[1]} an Müll und Plastik verhindert!',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
