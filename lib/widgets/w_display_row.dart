import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/widgets/w_text.dart';

import '../styles/colors.dart';

class WDisplayRowWidget extends StatelessWidget {
  final IconData iconLeft;
  final IconData iconRight;
  final String titleLeft;
  final String valueLeft;
  final String titleRight;
  final String valueRight;
  final Color? iconColorLeft;
  final Color? iconColorRight;
  final double? gap;

  const WDisplayRowWidget({
    super.key,
    required this.iconLeft,
    required this.iconRight,
    required this.titleLeft,
    required this.valueLeft,
    required this.titleRight,
    required this.valueRight,
    this.iconColorLeft,
    this.iconColorRight,
    this.gap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          iconLeft,
          size: 45,
          color: iconColorLeft ?? WColors.white,
        ),
        const Gap(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WText(text: titleLeft, size: 15),
            WText(text: valueLeft),
            Gap(gap ?? 0),
          ],
        ),
        const Gap(75),
        Icon(
          iconRight,
          size: 45,
          color: iconColorRight ?? WColors.white,
        ),
        const Gap(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WText(text: titleRight, size: 15),
            WText(text: valueRight)
          ],
        ),
      ],
    );
  }
}
