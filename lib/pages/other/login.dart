import 'package:flutter/material.dart';
import 'package:hello_worl2/model/user.dart';
import 'package:provider/provider.dart';
import 'package:hello_worl2/provider/userProvider.dart'; // Import your UserProvider

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
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
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                hintText: 'UserID',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_textEditingController.text.isNotEmpty) {
                context
                    .read<UserProvider>()
                    .setUser(User(userId: _textEditingController.text));
                Navigator.pop(context);
                Navigator.pushNamed(context, "/home");
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Bitte geben Sie eine UserID ein'),
                  ),
                );
              }
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
