import 'package:flutter/material.dart';

class Testingwidget extends StatelessWidget {
  const Testingwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Refill'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        width: 1290,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          "assets/image/wasserspender.jpg",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Text("titel"),
                      Text("filling_volume"),
                      Text("water_type"),
                      Text("water_degree"),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
