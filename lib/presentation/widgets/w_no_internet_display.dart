import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/presentation/widgets/w_button.dart';
import 'package:weather_app/presentation/widgets/w_text.dart';

import '../styles/colors.dart';

class WNoInternetDisplay extends StatelessWidget {
  final bool cache;
  final void Function() onTap;
  const WNoInternetDisplay({
    super.key,
    required this.cache,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WText(
          text: cache
              ? 'No cached weather data available. Check if you have internet connection and your location is turned on'
              : "To use this feature, make sure you're connected to the internet",
          textAlign: TextAlign.center,
          maxLines: 4,
        ),
        const Gap(20),
        const Icon(
          Icons.wifi_off_rounded,
          size: 200,
          color: WColors.white,
        ),
        const Gap(40),
        WButton(
          onTap: onTap,
          text: "Try again",
          textColor: WColors.white,
          btnColor: const Color.fromARGB(255, 65, 91, 127),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ],
    );
  }
}
