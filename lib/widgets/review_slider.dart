import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/rating_provider.dart';

class Reviewslider extends StatefulWidget {
  final String title;
  const Reviewslider({Key? key, required this.title}) : super(key: key);

  @override
  State<Reviewslider> createState() => _SliderState();
}

class _SliderState extends State<Reviewslider> {
  double _currentSliderValue = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ratingProvider = Provider.of<RatingProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        Slider(
          value: _currentSliderValue,
          max: 5,
          divisions: 5,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
              // Update the rating in the provider based on the title
              if (widget.title == "cleanliness") {
                ratingProvider.cleanlinessRating = value.round();
              } else if (widget.title == "accessibility") {
                ratingProvider.accessibilityRating = value.round();
              } else if (widget.title == "waterquality") {
                ratingProvider.waterQualityRating = value.round();
              }
            });
          },
        ),
      ],
    );
  }
}