import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_worl2/ui/widgets.dart/customText.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContributionKaiserslautern extends StatelessWidget {
  final List<String> input;
  const ContributionKaiserslautern({super.key, required this.input});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: const Text('Refill', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.lightBlueAccent),
      backgroundColor: const Color(0xff1c3845),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Image(image: AssetImage("assets/recycling.jpg")),
          const Padding(padding: EdgeInsets.all(10)),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: const CustomText(
              text: "Alle Refillstationen in Kaiserslautern",
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
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
                    color: Colors.white,
                    size: 40,
                  ),
                  CustomText(
                    text: input[0],
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const FaIcon(
                    FontAwesomeIcons.glassWaterDroplet,
                    color: Colors.white,
                    size: 40,
                  ),
                  CustomText(
                    text: input[1],
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.all(30)),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {},
              child: const CustomText(
                text: 'Zur Kaiserslautern Seite',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              )),
        ],
      ),
    );
  }
}
