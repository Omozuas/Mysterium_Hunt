import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_cube/flutter_cube.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Create a fade-in animation
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Start the animation
    _controller.forward();

    // Navigate to home screen after 2 seconds
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.blue),
          ),
          Center(
            child: FadeTransition(
              opacity: _animation,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min, // Prevents overflow
                children: [
                  Text(
                    'AR Treasure Hunt',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: SingleChildScrollView( // Added to handle overflow
        child: Column(
          children: [
            Container(
             
              height: 200, // Constrain height to avoid overflow
              child: Cube(
                onSceneCreated: (Scene scene) {
                  scene.world.add(Object(
                    scale: Vector3(1.0, 1.0, 1.0),
                    fileName: 'assets/cube.obj',
                  ));
                },
              ),
            ),
            Container(
              color: Colors.black,
              height: 200, // Constrain height to avoid overflow
              child: Cube(
                onSceneCreated: (Scene scene) {
                  scene.world.add(Object(
                    scale: Vector3(1.0, 1.0, 1.0),
                    fileName: 'assets/circle.obj',
                  ));
                },
              ),
            ),
            Container(
              color: Colors.black,
              height: 200, // Constrain height to avoid overflow
              child: Cube(
                onSceneCreated: (Scene scene) {
                  scene.world.add(Object(
                    scale: Vector3(1.0, 1.0, 1.0),
                    fileName: 'assets/coin.obj',
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
