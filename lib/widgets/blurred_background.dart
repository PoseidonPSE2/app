import 'dart:ui';
import 'package:flutter/material.dart';

class BlurredBackground extends StatelessWidget {
  const BlurredBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black45),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Blurred background
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                color: Colors.grey.shade600,
              ),
            ),
            // Striped pattern
            // CustomPaint(
            //   size: Size(screenWidth * 0.9, screenHeight / 3),
            //   painter: StripedPatternPainter(),
            // ),
          ],
        ),
      ),
    );
  }
}

class StripedPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 2;

    double spacing = 10.0;
    // double diagonalSpacing = spacing / 2;

    for (double i = -size.height; i < size.width; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }

    // for (double i = -size.height; i < size.width; i += spacing) {
    //   canvas.drawLine(
    //     Offset(i + diagonalSpacing, 0),
    //     Offset(i + size.height + diagonalSpacing, size.height),
    //     paint..color = Colors.grey.withOpacity(0.15),
    //   );
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
