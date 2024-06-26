import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_worl2/service/drawer/kl_contribution_service.dart';
import 'package:hello_worl2/widgets/loading.dart';

class KLContributionScreen extends StatefulWidget {
  @override
  _KLContributionScreenState createState() => _KLContributionScreenState();
}

class _KLContributionScreenState extends State<KLContributionScreen> {
  final KLContributionService klContributionService = KLContributionService();
  late Future<Map<String, dynamic>> futureContribution;

  @override
  void initState() {
    super.initState();
    futureContribution = klContributionService.fetchKLContribution();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Text(
            "Alle Refillstationen in Kaiserslautern",
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const FaIcon(
                  FontAwesomeIcons.handHoldingDroplet,
                  size: 40,
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder<Map<String, dynamic>>(
                  future: futureContribution,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingScreen();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No data available');
                    } else {
                      final data = snapshot.data!;
                      return Text(
                          '${data['amountRefillStationManual']}x Manuell');
                    }
                  },
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const FaIcon(
                  FontAwesomeIcons.glassWaterDroplet,
                  size: 40,
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder<Map<String, dynamic>>(
                  future: futureContribution,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingScreen();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('Keine Daten vorhanden');
                    } else {
                      final data = snapshot.data!;
                      return Text('${data['amountRefillStationSmart']}x Smart');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
