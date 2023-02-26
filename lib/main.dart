import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width - 50;
    const double containerHeight = 450;

    return Scaffold(
      body: Center(
        child: JotterContainer(
          width: containerWidth,
          height: containerHeight,
          child: Text('Home Indeed'),
        ),
      ),
    );
  }
}

class JotterContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child;

  const JotterContainer({
    super.key,
    required this.width,
    required this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: width,
            height: height,
            child: CustomPaint(
              painter: JotterContainerPainter(),
            ),
          ),
          child ?? const SizedBox(),
        ],
      ),
    );
  }
}

class JotterContainerPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    const double notchDiameter = 4;
    final int noOfNotches = size.width ~/ 16;
    final double notchSpacing = 
        (size.width - (noOfNotches * notchDiameter)) / (noOfNotches - 1);

    final paint = Paint()
      ..color = Colors.pink[200] as Color
      ..style = PaintingStyle.fill;

    final path = Path();
    // Origin at TopLeft corner
    path.moveTo(0, 0);
    // Algo for top notches
    double currentXPosition = 0;
    for (int i = 0; i < noOfNotches; i++) {
      path.addArc(
        Rect.fromCenter(
          center: Offset(currentXPosition + (notchDiameter / 2), 0),
          width: notchDiameter, 
          height: notchDiameter),
        pi, 
        0,
      );
      currentXPosition += notchSpacing;
      path.lineTo(currentXPosition, 0);
    }
    // Top right edge
    path.lineTo(size.width, 0);
    // Bottom right edge
    path.lineTo(size.width, size.height);
    // Algo for bottom notches
    //
    //
    // Bottom left edge
    path.lineTo(0, size.height);
    // Back to top left
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
