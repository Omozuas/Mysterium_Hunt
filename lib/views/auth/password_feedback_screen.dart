import 'package:argame/views/auth/log_in_screen.dart';
import 'package:argame/widgets/custom_full_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordFeedbackScreen extends StatelessWidget {
  const PasswordFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: Color(0xffD5DED5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Color(0xff006400),
                  size: 60,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Password Changed !',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff0E0E1B),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'You have successfully changed your password',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff737380),
                ),
              ),
              SizedBox(height: 20),
              FullButton(
                text: 'Go to Log In',
                width: double.infinity,
                height: 40,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogInScreen()));
                },
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
