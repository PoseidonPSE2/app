import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContributionKaiserslautern extends StatelessWidget {
  final List<String> input;
  const ContributionKaiserslautern({super.key, required this.input});

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
              "Alle Refillstationen in Kaiserslautern",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(padding: EdgeInsets.all(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const FaIcon(
                    FontAwesomeIcons.handHoldingDroplet,
                    size: 40,
                  ),
                  Text(
                    input[0],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const FaIcon(
                    FontAwesomeIcons.glassWaterDroplet,
                    size: 40,
                  ),
                  Text(
                    input[1],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.all(30)),
          ElevatedButton(
              onPressed: () {},
              child: Text(
                'Zur Kaiserslautern Seite',
                style: Theme.of(context).textTheme.bodyLarge,
              )),
        ],
      ),
    );
  }
}
