import 'package:flutter/material.dart';

class SpinningGlobe extends StatefulWidget {
  const SpinningGlobe({super.key});

  @override
  _SpinningGlobeState createState() => _SpinningGlobeState();
}

class _SpinningGlobeState extends State<SpinningGlobe>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // Time for one full rotation
      vsync: this,
    )..repeat(); // Loop the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Image.asset(
        'assets/images/globe.png', // Add this image to your project
        width: 150,
        height: 150,
      ),
    );
  }
}
