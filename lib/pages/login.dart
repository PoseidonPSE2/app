import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Refill - Poseidon"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image.asset(
              'assets/image/frontpage.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'UserID',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/home");
            },
            child: Text(
              'Login',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
