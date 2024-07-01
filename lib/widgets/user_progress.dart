import 'package:flutter/material.dart';
import 'package:refill/provider/user_provider.dart';
import 'package:provider/provider.dart';

class Progress extends StatelessWidget {
  const Progress({super.key});

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
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final userContribution = userProvider.userContribution;

        if (userContribution == null) {
          return const Center(child: Text('No data available'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(5),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.local_drink),
                            const SizedBox(width: 8),
                            Text(
                              ": ${userContribution.amountFillings} Füllungen",
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.euro),
                            const SizedBox(width: 8),
                            Text(
                              ": ${formatMoney(userContribution.savedMoney)}",
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.water_drop),
                            const SizedBox(width: 8),
                            Text(
                              ": ${formatVolume(userContribution.amountWater)}",
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.delete),
                            const SizedBox(width: 8),
                            Text(
                              ": ${formatWeight(userContribution.savedTrash)}",
                            ),
                          ],
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
