import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_worl2/model/refillstation.dart';
import 'package:hello_worl2/model/user.dart';
import 'package:hello_worl2/provider/refillstation_provider.dart';
import 'package:hello_worl2/provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../restApi/waterEnums.dart';
import 'WaterstationReport.dart';
import 'WaterstationReview.dart';

class Waterstationdetails extends StatefulWidget {
  final RefillStationMarker marker;

  const Waterstationdetails({super.key, required this.marker});

  @override
  State<Waterstationdetails> createState() => WaterstationdetailsState();
}

class WaterstationdetailsState extends State<Waterstationdetails> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = Provider.of<UserProvider>(context, listen: false).user;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchReviewData();
    });
  }

  Future<void> fetchReviewData() async {
    final provider = Provider.of<RefillStationProvider>(context, listen: false);
    await provider.getLike(widget.marker.id, currentUser!.userId);
    await provider.fetchReviewAverage(widget.marker.id);
    await provider.fetchStationById(widget.marker.id);
    await provider.getLikeCounterForStation(widget.marker.id);
  }

  Future<void> navigateToReviewPage(
      BuildContext context, RefillStation marker) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Waterstationreview(station: marker),
      ),
    );
    fetchReviewData(); // Fetch the latest review data when returning from the review page
  }

  void navigateToReportPage(BuildContext context, RefillStation marker) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Waterstationreport(station: marker),
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasserstation'),
        actions: [
          Consumer<RefillStationProvider>(
            builder: (context, provider, child) {
              return TextButton(
                onPressed: () {
                  navigateToReportPage(context, provider.selectedStation!);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Problem melden',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(decoration: TextDecoration.underline),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<RefillStationProvider>(
        builder: (context, provider, child) {
          if (provider.selectedStation == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: screenWidth * 0.3,
                                    height: screenHeight * 0.15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: provider.imageBase64?.image != null && provider.imageBase64!.image!.isNotEmpty
                                          ? DecorationImage(
                                        image: MemoryImage(base64Decode(provider.imageBase64!.image!)),
                                        fit: BoxFit.cover,
                                      )
                                          : DecorationImage(
                                        image: const AssetImage("assets/image/herz.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                provider.selectedStation!.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall,
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    provider.toggleLike(
                                                        widget.marker.id,
                                                        currentUser!.userId);
                                                  },
                                                  icon: Icon(
                                                    provider.isLiked
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: provider.isLiked
                                                        ? Colors.red
                                                        : Colors.grey,
                                                    size: 30,
                                                  ),
                                                ),
                                                Text(
                                                  provider.likes.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on_sharp,
                                              size: 22.0,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              formatAddressWithLineBreak(
                                                  provider.selectedStation!
                                                      .address),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        provider.reviewAverage!.accesibility
                                            .toStringAsFixed(1)
                                            .toString(),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Icon(
                                        Icons.star,
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    ' · ',
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        provider.reviewAverage!.cleanness
                                            .toStringAsFixed(1)
                                            .toString(),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Icon(
                                        Icons.star,
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    ' · ',
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        provider.reviewAverage!.waterQuality
                                            .toStringAsFixed(1)
                                            .toString(),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Icon(
                                        Icons.star,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Erreichbarkeit",
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Sauberkeit",
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Wasser Qualität",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          provider.selectedStation!.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.water_drop,
                              size: 22.0,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              offeredWaterTypeToString(
                                  provider.selectedStation!.offeredWatertype),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.glassWaterDroplet,
                              size: 22.0,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              waterStationTypeToString(
                                  provider.selectedStation!.type),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.water_rounded,
                              size: 22.0,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              provider.selectedStation!.waterSource,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 15, right: 15, bottom: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      print("test2");
                      navigateToReviewPage(context, provider.selectedStation!);
                    },
                    child: Text('Bewerten'),
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
