import 'package:flutter/material.dart';
import 'package:refill/provider/refillstation_provider.dart';
import 'package:refill/widgets/refillstation_details.dart';
import 'package:provider/provider.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      key: _sheet,
      initialChildSize: 0.3,
      maxChildSize: 1,
      minChildSize: 0.1,
      expand: true,
      snap: true,
      snapSizes: const [0.5],
      controller: _controller,
      builder: (BuildContext context, ScrollController scrollController) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 70,
                height: 6,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              Expanded(
                child: Consumer<RefillStationProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (provider.errorMessage != null) {
                      return Center(
                          child: Text('Error: ${provider.errorMessage}'));
                    } else if (provider.stationMarkers.isEmpty) {
                      return const Center(
                          child: Text('Keine Refill-Station vorhanden!'));
                    } else {
                      final detailsList = provider.stationMarkers;
                      return CustomScrollView(
                        controller: scrollController,
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final marker = detailsList[index];
                                return RefillstationDetails(
                                  marker: marker,
                                );
                              },
                              childCount: detailsList.length,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
