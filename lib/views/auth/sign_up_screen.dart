import 'package:argame/views/auth/log_in_screen.dart';
import 'package:argame/views/auth/sign_up_feedback_screen.dart';
import 'package:argame/widgets/custom_full_button.dart';
import 'package:argame/widgets/custom_password_field.dart';
import 'package:argame/widgets/custom_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/images/hunt.jpeg'))),
      child: Scaffold(
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignUpFeedbackScreen()));
          },
          child: Container(
            height: 50,
            width: 53,
            decoration: const BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(9)),
            ),
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    'Sign Up!',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Fill in the details correctly to register an account successfully',
                  style: GoogleFonts.syne(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 20),
                Text(
                  'Username',
                  style: GoogleFonts.syne(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                buildTextField(
                    type: TextInputType.text, hintText: 'prodigy_rejoice'),
                SizedBox(height: 10),
                Text(
                  'Email',
                  style: GoogleFonts.syne(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                buildTextField(
                    type: TextInputType.emailAddress,
                    hintText: 'prodigy@gmail.com'),
                SizedBox(height: 10),
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
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                const PasswordField(hintText: 'Enter Password'),
                SizedBox(height: 40),
                FullButton(
                  text: 'Create Account',
                  width: double.infinity,
                  height: 44,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpFeedbackScreen()));
                  },
                  color: Colors.white,
                ),
                SizedBox(height: 15),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Already have a account? ',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            )),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LogInScreen())),
                          text: 'Login',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
