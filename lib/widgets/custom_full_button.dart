import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FullButton extends StatelessWidget {
  final String text;
  final Color color;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final VoidCallback? longPressed;
  final double fontSize;

  const FullButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.onPressed,
    required this.color,
    this.longPressed,
    this.fontSize = 15,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      onLongPress: longPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.brown,
        ),
        child: Center(
          child: Text(text,
              style: GoogleFonts.poppins(
                  color: Color(0xffFFFFFF),
                  fontSize: 14,
                  fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}
