import 'package:flutter/material.dart';
import 'package:hello_worl2/pages/WaterstationReport.dart';
import 'package:hello_worl2/pages/WaterstationReview.dart';
import 'package:hello_worl2/restApi/mapper.dart';
import 'package:provider/provider.dart';
import '../provider/ratingProvider.dart';
import '../restApi/waterEnums.dart';

class Waterstationdetails extends StatefulWidget {
  final RefillStation station;
  final double averageReview;

  const Waterstationdetails(
      {super.key, required this.station, required this.averageReview});

  @override
  State<Waterstationdetails> createState() => WaterstationdetailsState();
}

class WaterstationdetailsState extends State<Waterstationdetails> {
  bool _liked = false;

  void navigateToReportPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Waterstationreport(station: widget.station),
      ),
    );
  }

  void navigateToReviewPage(BuildContext context, RefillStation marker) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<RatingProvider>(
          create: (_) => RatingProvider(),
          child: Waterstationreview(station: widget.station),
        ),
      ),
    );
  }

  static String formatAddressWithLineBreak(String address) {
    List<String> addressParts = address.split(', ');

    String formattedAddress = addressParts[0] + ",\n" + addressParts[1];
    return formattedAddress;
  }

  List<Widget> generateStarRating(double rating) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      double filledStarRatio = (rating - i) >= 0 ? 1 : rating - i;
      Icon starIcon;
      if (filledStarRatio >= 0.5) {
        starIcon = Icon(
          Icons.star,
          color: Colors.yellow[700],
          size: 20.0,
        );
      } else if (filledStarRatio > 0) {
        starIcon = Icon(
          Icons.star_half,
          color: Colors.yellow[700],
          size: 20.0,
        );
      } else {
        starIcon = Icon(
          Icons.star_border,
          color: Colors.grey[500],
          size: 20.0,
        );
      }
      stars.add(starIcon);
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    List<Widget> stars = generateStarRating(widget.averageReview);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasserstation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              width: screenWidth,
              height: (screenHight / 3),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/image/herz.jpg"),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 160.0,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 25.0),
                    height: 160.0,
                    width: screenWidth - 40,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 2.0, color: Colors.white),
                        top: BorderSide(width: 2.0, color: Colors.white),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(widget.station.name,
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            SizedBox(
                              width: 60,
                            ),
                            Text(
                              widget.station.likeCounter.toString(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _liked = !_liked;
                                });
                              },
                              icon: Icon(
                                _liked ? Icons.favorite : Icons.favorite_border,
                                color: _liked ? Colors.red : null,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.station.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0),
              height: 120.0,
              width: screenWidth - 40,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_sharp,
                        size: 22.0,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        formatAddressWithLineBreak(widget.station.address),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_alarm,
                        size: 22.0,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.station.openingTimes,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Expanded(child: Text("Bewertung: ")),
                      Expanded(child: Row(children: stars)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.water_drop,
                        size: 22.0,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        offeredWaterTypeToString(
                            widget.station.offeredWatertype),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.local_gas_station,
                        size: 22.0,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        waterStationTypeToString(widget.station.type),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.gas_meter_outlined,
                        size: 22.0,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.station.waterSource,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: screenWidth - 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      navigateToReviewPage(context, widget.station);
                    },
                    child: Text(
                      'Bewerten',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      navigateToReportPage(context);
                    },
                    child: Text(
                      'Problem melden',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
