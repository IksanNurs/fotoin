import 'package:flutter/material.dart';
import 'package:fotoin/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonOutlineGlobal extends StatelessWidget {
  const ButtonOutlineGlobal({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(45)
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: primaryColor,
            fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }
}