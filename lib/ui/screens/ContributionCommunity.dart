import 'package:flutter/material.dart';
import 'package:hello_worl2/ui/widgets.dart/customText.dart';

class ContributionCommunity extends StatelessWidget {
  final List<String> input;
  const ContributionCommunity({super.key, required this.input});

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
            child: CustomText(
              text: "Du bist einer von ${input[0]} aktiven Refillern!",
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: CustomText(
              text:
                  'Gemeinsam habt ihr ${input[1]} an Müll und Plastik verhindert!',
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: CustomText(
              text: 'Das sind ${input[2]} mehr als letztes Jahr!',
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
