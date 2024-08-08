import 'package:argame/views/auth/password_feedback_screen.dart';
import 'package:argame/widgets/custom_full_button.dart';
import 'package:argame/widgets/custom_password_field.dart';
import 'package:argame/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                'Reset Password',
                style: GoogleFonts.inter(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Text(
                'Set a new password for your account and rush back to hunting!',
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff737380))),
            SizedBox(height: 20),
            Text(
              'Password',
              style: GoogleFonts.syne(
                  color: const Color(0xff565050),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            const PasswordField(hintText: 'Enter Password'),
            SizedBox(height: 10),
            Text(
              'Confirm Password',
              style: GoogleFonts.syne(
                  color: const Color(0xff565050),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            const PasswordField(hintText: 'Enter Password Again'),
            SizedBox(height: 10),
            SizedBox(height: 40),
            FullButton(
              text: 'Submit',
              width: double.infinity,
              height: 40,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PasswordFeedbackScreen()));
              },
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
