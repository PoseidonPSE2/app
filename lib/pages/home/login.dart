import 'package:flutter/material.dart';
import 'package:hello_worl2/model/user.dart';
import 'package:provider/provider.dart';
import 'package:hello_worl2/provider/user_provider.dart';
import 'package:hello_worl2/provider/refillstation_provider.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<UserProvider, RefillStationProvider>(
        builder: (context, userProvider, refillStationProvider, child) {
          return userProvider.isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
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
                        decoration: const InputDecoration(
                          hintText: 'User',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_textEditingController.text.isNotEmpty) {
                          userProvider.setUser(User(userId: 4));

                          // Set the RefillStationProvider in UserProvider
                          userProvider
                              .setRefillStationProvider(refillStationProvider);

                          // Rufen Sie die Methode zum Sammeln der Daten auf
                          await userProvider.fetchDataAfterLogin();

                          Navigator.pop(context);
                          Navigator.pushNamed(context, "/home");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Bitte geben Sie einen User ein'),
                            ),
                          );
                        }
                      },
                      child: Text("Login"),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
