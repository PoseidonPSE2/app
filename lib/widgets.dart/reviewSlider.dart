import 'package:flutter/material.dart';

class Reviewslider extends StatefulWidget {
  final double initialValue;
  const Reviewslider({Key? key, required this.initialValue}) : super(key: key);

  @override
  State<Reviewslider> createState() => _SliderState();
}

class _SliderState extends State<Reviewslider> {
  double _currentSliderValue = 0;

  @override
  void initState() {
    super.initState();
    _currentSliderValue = widget.initialValue;
  }

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
