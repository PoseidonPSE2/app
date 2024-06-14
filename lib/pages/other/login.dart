import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_worl2/model/user.dart';
import 'package:provider/provider.dart';
import 'package:hello_worl2/provider/userProvider.dart'; // Import your UserProvider

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                hintText: 'UserID',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_textEditingController.text.isNotEmpty) {
                int? userId = int.tryParse(_textEditingController.text);
                if (userId != null) {
                  context.read<UserProvider>().setUser(User(userId: userId));
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/home");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Ungültige UserID. Bitte geben Sie eine gültige Zahl ein'),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Bitte geben Sie eine UserID ein'),
                  ),
                );
              }
            },
            child: const Text(
              'Login',
            ),
          ),
        ],
      ),
    );
  }
}
