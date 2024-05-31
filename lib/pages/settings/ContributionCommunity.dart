import 'package:flutter/material.dart';
import 'package:hello_worl2/service/settings/community_service.dart';

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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Image(image: AssetImage("assets/image/recycling.jpg")),
                const Padding(padding: EdgeInsets.all(10)),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Text(
                    "Du bist einer von ${data['amountUser'] + 1} aktiven Refillern!",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    'Gemeinsam habt ihr ${data['savedTrash']} an Müll und Plastik verhindert.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    'Ihr habt insgesamt ${data['amountFillings']} Füllungen durchgeführt und dabei ${data['savedMoney']} gespart.',
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
