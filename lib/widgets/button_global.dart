import 'package:flutter/material.dart';
import 'package:fotoin/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonGlobal extends StatelessWidget {
  const ButtonGlobal({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(45)
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }
}