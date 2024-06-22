import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          hintText: 'UserID',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_textEditingController.text.isNotEmpty) {
                          int? userId =
                              int.tryParse(_textEditingController.text);
                          if (userId != null) {
                            userProvider.setUser(User(userId: userId));

                            // Set the RefillStationProvider in UserProvider
                            userProvider.setRefillStationProvider(
                                refillStationProvider);

                            // Rufen Sie die Methode zum Sammeln der Daten auf
                            await userProvider.fetchDataAfterLogin();

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
                      child: Text("Login"),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
