import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_worl2/pages/WaterstationReport.dart';
import 'package:hello_worl2/pages/WaterstationReview.dart';
import 'package:hello_worl2/restApi/mapper.dart';
import 'navbar/map.dart';

class Waterstationdetails extends StatelessWidget {
  final RefillStation station;

  const Waterstationdetails({super.key, required this.station});

  void navigateToReportPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  Waterstationreport(station: station),
      ),
    );
  }

  void navigateToReviewPage(BuildContext context, RefillStation marker) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Waterstationreview(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wasserstation Details'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: TextButton(
                          onPressed: () {
                            navigateToReportPage(context);
                          },
                          child: Text(
                            'Ein Problem melden',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    decoration: TextDecoration.underline),
                          ),
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    station.name,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Left-align text
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              station.address,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            station.likeCounter.toString(),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        station.description,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        'Status: ${station.active ? 'Aktiv' : 'Inaktiv'}',
                        style: Theme.of(context).textTheme.labelLarge,
                      ), //Text('Zugänglich: ${marker.openingTimes}')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      navigateToReviewPage(context, station);
                    },
                    child: Text(
                      'Bewerten',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ]),
        ));
  }
}
