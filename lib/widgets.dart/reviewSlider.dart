import 'package:flutter/material.dart';

class Reviewslider extends StatefulWidget {
  const Reviewslider({Key? key, required reviewvalue}) : super(key: key);

  @override
  State<Reviewslider> createState() => _SliderState();
}

class _SliderState extends State<Reviewslider> {
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currentSliderValue,
      max: 5,
      divisions: 5,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
    );
  }
}
