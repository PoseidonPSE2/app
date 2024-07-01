import 'package:flutter/material.dart';
import 'package:refill/model/user.dart';
import 'package:refill/model/refillstation.dart';
import 'package:refill/provider/user_provider.dart';
import 'package:refill/provider/refillstation_provider.dart';
import 'package:provider/provider.dart';

class RefillstationDetails extends StatefulWidget {
  final RefillStationMarker marker;
  const RefillstationDetails({super.key, required this.marker});

  @override
  State<RefillstationDetails> createState() => _RefillstationDetailsState();
}

class _RefillstationDetailsState extends State<RefillstationDetails> {
  User? currentUser;
  late RefillStationProvider provider;

  @override
  void initState() {
    super.initState();
    currentUser = Provider.of<UserProvider>(context, listen: false).user;
    provider = Provider.of<RefillStationProvider>(context, listen: false);
  }

  static String formatAddressWithLineBreak(String address) {
    List<String> addressParts = address.split(', ');

    String formattedAddress = "${addressParts[0]},\n${addressParts[1]}";
    return formattedAddress;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Consumer<RefillStationProvider>(
      builder: (context, provider, child) {
        final selectedStation = provider.selectedStation;
        final reviewAverage = provider.reviewAverage;
        final likes = provider.likes;
        final isLiked = provider.isLiked;

        if (selectedStation == null || reviewAverage == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: AssetImage("assets/image/herz.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              selectedStation.name,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.toggleLike(
                                      widget.marker.id, currentUser!.userId);
                                  setState(() {});
                                },
                                icon: Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isLiked ? Colors.red : Colors.grey,
                                  size: 30,
                                ),
                              ),
                              Text(
                                isLiked
                                    ? (likes + 1).toString()
                                    : likes.toString(),
                                style: Theme.of(context).textTheme.bodyLarge,
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
                            formatAddressWithLineBreak(selectedStation.address),
                            style: Theme.of(context).textTheme.labelLarge,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      reviewAverage.accesibility.toStringAsFixed(1),
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
                      reviewAverage.cleanness.toStringAsFixed(1),
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
                      reviewAverage.waterQuality.toStringAsFixed(1),
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
          ],
        );
      },
    );
  }
}
