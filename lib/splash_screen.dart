import 'package:argame/Ar_Services/arScreen.dart';
import 'package:argame/profile_screen.dart';
import 'package:argame/views/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF010B1B),
      body: Center(
        child: CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/splash.png'),
        ),
      ),
    );
  }
}
