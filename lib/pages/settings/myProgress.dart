import 'package:flutter/material.dart';
import 'package:hello_worl2/provider/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:hello_worl2/model/user.dart';
import 'package:hello_worl2/service/settings/user_contribution_service.dart';

class MyProgress extends StatefulWidget {
  const MyProgress({Key? key}) : super(key: key);

  @override
  _MyProgressState createState() => _MyProgressState();
}

class _MyProgressState extends State<MyProgress> {
  late Future<Map<String, dynamic>> futureContribution;

  @override
  void initState() {
    super.initState();
    // Zugriff auf den UserProvider und Abrufen des Benutzers
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final User? user = userProvider.user;

    // Verwendung des Benutzers, um die Benutzerbeitragsdaten abzurufen
    final userContributionService = UserContributionService();
    futureContribution = userContributionService.fetchUserContribution(user!);
  }

  String formatMoney(double amount) {
    int euro = amount.truncate();
    int cent = ((amount - euro) * 100).round();

    return '$euro,$cent€';
  }

  String formatVolume(int milliliters) {
    if (milliliters < 1000) {
      return '$milliliters ml';
    } else {
      double liters = milliliters / 1000;
      return '${liters.toStringAsFixed(liters.truncateToDouble() == liters ? 0 : 2)} Liter';
    }
  }

  String formatWeight(double grams) {
    int kg = grams.truncate();
    int g = ((grams - kg) * 100).round();
    return '$kg,${g}kg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Refill'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: futureContribution,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final data = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Image(
                  image: AssetImage("assets/image/herz.jpg"),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Text(
                    "Du hast insgesamt ${data['amountFillings']} Füllungen durchgeführt.",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Text(
                    "Du hast insgesamt ${formatVolume(data['amountWater'])} Wasser gefüllt.",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    'Das entspricht ${formatMoney(data['savedMoney'])} gesparten Euro und ${formatWeight(data['savedTrash'])} an Müll verhindert',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
