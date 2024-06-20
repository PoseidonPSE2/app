import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class WaterloadingAnimation extends StatefulWidget {
  @override
  _WaterloadingAnimationState createState() => _WaterloadingAnimationState();
}

class _WaterloadingAnimationState extends State<WaterloadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFull = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // Animation duration is 5 seconds
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _isFull = true;
          });
          // Show SnackBar when animation is complete
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Die Flasche ist voll!'),
            ),
          );
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _isFull = false; // Reset full status
    _controller.reset(); // Reset animation
    _controller.forward(); // Start the animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Water Bottle Indicator"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:
                  _isFull ? null : _startAnimation, // Disable button when full
              child: Text(
                'Start Animation',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 400,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return LiquidCustomProgressIndicator(
                    value: _animation.value, // Use the animated value
                    valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                    backgroundColor: Colors.white,
                    direction: Axis.vertical,
                    shapePath: _buildBottlePath(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Path _buildBottlePath() {
    return Path()
      ..moveTo(75, 0) // Start at the top-center
      ..lineTo(125, 0) // Top-right corner of the bottle neck
      ..lineTo(125, 30) // Down to the shoulder
      ..quadraticBezierTo(
          125, 45, 100, 50) // Curve the shoulder to the right side
      ..quadraticBezierTo(75, 45, 75, 30) // Curve the shoulder to the left side
      ..lineTo(75, 0) // Close the neck
      ..moveTo(50, 50) // Move to the top left of the bottle
      ..lineTo(150, 50) // Top right of the bottle
      ..quadraticBezierTo(175, 100, 150, 150) // Right side curve
      ..lineTo(150, 300) // Right side down
      ..quadraticBezierTo(150, 350, 100, 350) // Bottom right curve
      ..quadraticBezierTo(50, 350, 50, 300) // Bottom left curve
      ..lineTo(50, 150) // Left side up
      ..quadraticBezierTo(25, 100, 50, 50) // Left side curve
      ..close(); // Close the path
  }
}
