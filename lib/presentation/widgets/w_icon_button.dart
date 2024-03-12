import 'package:flutter/material.dart';
import 'package:weather_app/presentation/styles/colors.dart';

class WIconButton extends StatelessWidget {
  final IconData icon;
  final Color? btnColor;
  final Color? iconColor;
  final double? size;
  final VoidCallback onTap;
  final String semantics;

  const WIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.btnColor,
    this.iconColor,
    this.size,
    this.semantics = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        // border: Border.all(color: WColors.black)
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          icon,
          color: iconColor ?? WColors.white,
          size: size ?? 45,
          semanticLabel: semantics,
        ),
      ),
    );
  }
}
