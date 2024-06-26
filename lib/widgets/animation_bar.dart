import 'package:flutter/material.dart';

class AnimatedProgressbar extends StatelessWidget {
  final double value;

  const AnimatedProgressbar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      backgroundColor: Colors.grey[300],
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }
}
