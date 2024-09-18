import 'package:flutter/material.dart';
import 'package:fotoin/theme.dart';
import 'package:google_fonts/google_fonts.dart';



class TextLabel extends StatelessWidget {
  const TextLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      
      ),
    );
  }
}