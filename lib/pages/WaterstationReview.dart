import 'package:flutter/material.dart';
import 'package:hello_worl2/model/refillstation.dart';
import 'package:hello_worl2/provider/refillstation_provider.dart';
import 'package:hello_worl2/provider/user_provider.dart';
import 'package:hello_worl2/restApi/apiService.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';

class Waterstationreview extends StatefulWidget {
  final RefillStation station;

  const Waterstationreview({super.key, required this.station});

  @override
  State<Waterstationreview> createState() => _WaterstationreviewState();
}

class _WaterstationreviewState extends State<Waterstationreview> {
  User? currentUser;

  double cleanlinessRating = 0;
  double accessibilityRating = 0;
  double waterQualityRating = 0;

  @override
  void initState() {
    super.initState();
    currentUser = Provider.of<UserProvider>(context, listen: false).user;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserRatings();
    });
  }

  Future<void> _fetchUserRatings() async {
    try {
      await Provider.of<RefillStationProvider>(context, listen: false)
          .fetchReview(currentUser!.userId, widget.station.id);
      setState(() {
        final provider =
            Provider.of<RefillStationProvider>(context, listen: false);
        final review = provider.review;
        if (review != null) {
          cleanlinessRating = review.cleanness.toDouble();
          accessibilityRating = review.accessibility.toDouble();
          waterQualityRating = review.water_quality.toDouble();
        }
      });
    } catch (error) {
      print('Fehler beim Laden der Bewertungen: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RefillStationProvider>(context);
    final review = provider.review;

    if (review == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Wasserstation Details'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasserstation Details'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Sauberkeit', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 10),
              RatingBar.builder(
                initialRating: cleanlinessRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    cleanlinessRating = rating;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text('Erreichbarkeit',
                  style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 10),
              RatingBar.builder(
                initialRating: accessibilityRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    accessibilityRating = rating;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text('Wasserqualität',
                  style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 10),
              RatingBar.builder(
                initialRating: waterQualityRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    waterQualityRating = rating;
                  });
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  RefillstationReview review = RefillstationReview(
                    cleanness: cleanlinessRating.toInt(),
                    accessibility: accessibilityRating.toInt(),
                    water_quality: waterQualityRating.toInt(),
                    station_id: widget.station.id,
                    user_id: currentUser?.userId,
                  );
                  ApiService().postRefillstationReview(review);
                  await provider.fetchReviewAverage(widget.station.id);
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Text(
                  'Absenden',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
