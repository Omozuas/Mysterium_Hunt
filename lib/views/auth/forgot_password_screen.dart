import 'package:argame/views/auth/reset_password.dart';
import 'package:argame/widgets/custom_full_button.dart';
import 'package:argame/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                'Forgot Password',
                style: GoogleFonts.inter(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Text('Enter your email to receive a password reset link',
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff737380))),
            SizedBox(height: 20),
            Text(
              'Email',
              style: GoogleFonts.syne(
                  color: const Color(0xff565050),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            buildTextField(
                type: TextInputType.emailAddress,
                hintText: 'prodigy@gmail.com'),
            SizedBox(height: 10),
            SizedBox(height: 40),
            FullButton(
              text: 'Send Link',
              width: double.infinity,
              height: 40,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ResetPassword()));
              },
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
