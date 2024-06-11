import 'package:flutter/material.dart';

class AnimatedProgressbar extends StatelessWidget {
  final double value;

  AnimatedProgressbar({required this.value});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      backgroundColor: Colors.grey[300],
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }
}
