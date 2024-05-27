import 'package:flutter/material.dart';

class MyProgress extends StatelessWidget {
  final List<String> input;
  const MyProgress({super.key, required this.input});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Refill'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Image(
            image: AssetImage("assets/image/recycling.jpg"),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              "Du hast insgesamt ${input[0]} Füllungen duchgeführt",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              'Das entspricht ${input[1]} gesparte Euro und ${input[2]} an Müll verhindert',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
