import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/w_text.dart';

import '../styles/colors.dart';

class WButton extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;
  final TextAlign textAlign = TextAlign.center;
  final Color textColor;
  final Color btnColor;
  final Color? borderColor;
  final double? size;
  final FontWeight? weight;
  final VoidCallback onTap;

  const WButton({
    super.key,
    required this.text,
    required this.padding,
    required this.btnColor,
    required this.textColor,
    required this.onTap,
    this.borderColor,
    this.size,
    this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: btnColor,
          border: Border.all(
              color: borderColor ?? WColors.white.withOpacity(0), width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: padding,
          child: WText(
            text: text,
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
