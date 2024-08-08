import 'package:argame/profile_screen.dart';
import 'package:argame/views/auth/forgot_password_screen.dart';
import 'package:argame/views/auth/sign_up_screen.dart';
import 'package:argame/widgets/custom_full_button.dart';
import 'package:argame/widgets/custom_password_field.dart';
import 'package:argame/widgets/custom_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool? checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Log In!',
                  style: GoogleFonts.inter(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Provide your credentials to access your saved progress and continue hunting!',
                style: GoogleFonts.syne(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20),
              Text(
                'Email or username',
                style: GoogleFonts.syne(
                    color: const Color(0xff565050),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              buildTextField(
                  type: TextInputType.text, hintText: 'prodigy_rejoice'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          side: const BorderSide(color: Color(0xffD8D8DD)),
                          activeColor: Colors.brown,
                          value: checkBoxValue,
                          onChanged: (bool? newValue) {
                            setState(() {
                              checkBoxValue = newValue;
                            });
                          }),
                      Text(
                        'Remember me',
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => ForgotPasswordScreen()));
                    },
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: const Color(0xffD9291E)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              FullButton(
                text: 'Log Into Account',
                width: double.infinity,
                height: 44,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
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
                          text: 'Don’t have account? ',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff737380))),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen())),
                        text: 'Sign Up',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: const Color(0xffEC8305)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
