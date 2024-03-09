import 'package:flutter/material.dart';

import '../styles/colors.dart';

class WText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final int? maxLines;
  final TextDecoration? underline;
  final TextAlign? textAlign;

  const WText({
    super.key,
    required this.text,
    this.size,
    this.weight,
    this.color,
    this.maxLines,
    this.underline,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size ?? 20,
        fontWeight: weight ?? FontWeight.w500,
        fontFamily: 'Diodrum',
        color: color ?? WColors.white,
        decoration: underline ?? TextDecoration.none,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines ?? 2,
    );
  }
}
