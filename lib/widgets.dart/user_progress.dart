import 'package:flutter/material.dart';
import 'package:hello_worl2/model/user.dart';
import 'package:hello_worl2/model/user_contribution.dart';
import 'package:hello_worl2/provider/userProvider.dart';
import 'package:hello_worl2/service/settings/user_contribution_service.dart';
import 'package:provider/provider.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  late Future<UserContribution> futureContribution;
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final User? user = userProvider.user;

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
    return FutureBuilder<UserContribution>(
      future: futureContribution,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Column(
            children: [
              Center(child: CircularProgressIndicator()),
            ],
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Center(child: Text('Error: ${snapshot.error}')),
            ],
          );
        } else if (!snapshot.hasData) {
          return const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(child: Text('No data available')),
          );
        } else {
          final data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(5),
            // top: 20.0, left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Center(
                    child: Text(
                      "Mein Beitrag",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.local_drink),
                        const SizedBox(width: 8),
                        Text(
                          ": ${data.amountFillings} Füllungen",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.water_drop),
                        const SizedBox(width: 8),
                        Text(
                          ": ${formatVolume(data.amountWater)}",
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.euro),
                        const SizedBox(width: 8),
                        Text(
                          ": ${formatMoney(data.savedMoney)}",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.delete),
                        const SizedBox(width: 8),
                        Text(
                          ": ${formatWeight(data.savedTrash)}",
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
