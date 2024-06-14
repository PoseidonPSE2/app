import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_worl2/service/settings/kl_contribution_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Refill'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: futureContribution,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            final data = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.all(30)),
                const SizedBox(
                  width: 500,
                  height: 200,
                  child: Image(image: AssetImage("assets/image/refill_kl.png")),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Text(
                    "Alle Refillstationen in Kaiserslautern",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const FaIcon(
                          FontAwesomeIcons.handHoldingDroplet,
                          size: 40,
                        ),
                        Text(
                          '${data['amountRefillStationManual']}x Manuell',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const FaIcon(
                          FontAwesomeIcons.glassWaterDroplet,
                          size: 40,
                        ),
                        Text(
                          '${data['amountRefillStationSmart']}x Smart',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(30)),
                ElevatedButton(
                  onPressed: () {
                    launchUrlString(
                        'https://www.kaiserslautern.de/sozial_leben_wohnen/umwelt/klimaschutz/projekte/055055/index.html.de');
                  },
                  child: const Text(
                    'Zur Kaiserslautern Seite',
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
