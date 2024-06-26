import 'package:flutter/material.dart';
import 'package:hello_worl2/pages/drawer/contribution_kl.dart';
import 'package:hello_worl2/service/drawer/community_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CommunityContributionScreen extends StatefulWidget {
  @override
  _CommunityContributionScreenState createState() =>
      _CommunityContributionScreenState();
}

class _CommunityContributionScreenState
    extends State<CommunityContributionScreen> {
  final CommunityService communityService = CommunityService();
  Future<Map<String, dynamic>>? futureContribution;

  @override
  void initState() {
    super.initState();
    futureContribution = communityService.fetchCommunityContribution();
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
      return '${liters.toStringAsFixed(liters.truncateToDouble() == liters ? 0 : 1)} Liter';
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
        title: const Text('Community Beitrag'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 400,
            height: 150,
            child: Image(image: AssetImage("assets/image/refill_kl.png")),
          ),
          KLContributionScreen(),
          const Padding(padding: EdgeInsets.all(10)),
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder<Map<String, dynamic>>(
                future: futureContribution,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Keine Daten vorhanden!'));
                  } else {
                    final data = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: Text(
                            "Du bist einer von ${data['amountUser']} aktiven Refillern!",
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text(
                            'Gemeinsam habt ihr ${formatWeight((data['savedTrash'] as num).toDouble())} an Müll und Plastik verhindert.',
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text(
                            'Ihr habt insgesamt ${formatVolume(data['amountWater'])} Wasser gefüllt.',
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text(
                            'Ihr habt insgesamt ${data['amountFillings']} Füllungen durchgeführt und dabei ${formatMoney((data['savedMoney'] as num).toDouble())} gespart.',
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: ElevatedButton(
              onPressed: () {
                launchUrlString(
                    'https://www.kaiserslautern.de/sozial_leben_wohnen/umwelt/klimaschutz/projekte/055055/index.html.de');
              },
              child: const Text(
                'Zur Kaiserslautern Seite',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
