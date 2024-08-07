import 'package:argame/views/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MysteriousHunt());
}

class MysteriousHunt extends StatelessWidget {
  const MysteriousHunt({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: SignUpScreen(),
    );
  }
}
