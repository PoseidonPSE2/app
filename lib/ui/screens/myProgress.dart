import 'package:flutter/material.dart';
import 'package:hello_worl2/ui/widgets.dart/customText.dart';

class MyProgress extends StatelessWidget {
  final List<String> input;
  const MyProgress({super.key, required this.input});

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Image(image: AssetImage("assets/recycling.jpg")),
          const Padding(padding: EdgeInsets.all(10)),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: CustomText(
              text: "Du hast insgesamt ${input[0]} Füllungen duchgeführt",
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: CustomText(
              text:
                  'Das entspricht ${input[1]} gesparte Euro und ${input[2]} an Müll verhindert',
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
