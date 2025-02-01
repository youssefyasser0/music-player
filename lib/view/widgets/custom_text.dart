// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
    final String title;
    final double? fontSize;
    final FontWeight? fontWeight;
    final Color? color;
    final TextOverflow? overflow;
  const CustomText({
    super.key,
    required this.title,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: overflow,
      title , style: GoogleFonts.poppins(
      fontSize: fontSize , fontWeight: fontWeight , color: color
    ),
    );
  }
}
