import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/presentation/widgets/w_app_icons.dart';
import 'package:weather_app/presentation/widgets/w_display_row.dart';
import 'package:weather_app/presentation/widgets/w_icon_button.dart';
import 'package:weather_app/presentation/widgets/w_text.dart';

import '../styles/colors.dart';

class WeatherDisplay extends StatelessWidget {
  const WeatherDisplay(
      {super.key,
      required this.areaName,
      required this.temperature,
      required this.icon,
      required this.weather,
      required this.date,
      required this.tempMax,
      required this.tempMin,
      required this.sunset,
      required this.sunrise,
      required this.canNavigateBack});
  final String areaName;
  final String temperature;
  final IconData icon;
  final String weather;
  final DateTime date;
  final String tempMax;
  final String tempMin;
  final DateTime sunset;
  final DateTime sunrise;
  final bool canNavigateBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(35),
        canNavigateBack
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Gap(15),
                  WIconButton(
                      icon: Icons.keyboard_arrow_left_rounded,
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: WText(
                        text: areaName,
                        textAlign: TextAlign.center,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              )
            : WText(
                text: areaName,
                textAlign: TextAlign.center,
                size: 35,
              ),
        const Gap(30),
        Icon(
          icon,
          size: 225,
          color: WColors.white,
        ),
        const Gap(15),
        WText(
          text: temperature,
          size: 70,
          weight: FontWeight.w600,
        ),
        WText(
          text: weather,
          size: 25,
          weight: FontWeight.w600,
        ),
        const Gap(10),
        WText(
          text: DateFormat("E MMMM d | ").format(date) +
              DateFormat("jm").format(date),
          size: 18,
          weight: FontWeight.w500,
        ),
        const Gap(50),
        WDisplayRowWidget(
          iconLeft: WeatherAppIcons.temperatire,
          iconColorLeft: WColors.red,
          titleLeft: "Max Temps",
          valueLeft: tempMax,
          iconRight: WeatherAppIcons.temperatire,
          iconColorRight: WColors.lightBlue,
          titleRight: "Min Temps",
          valueRight: tempMin,
        ),
        const Divider(
          thickness: 1.5,
          color: WColors.white,
          height: 35,
          indent: 20,
          endIndent: 20,
        ),
        WDisplayRowWidget(
          iconLeft: WeatherAppIcons.sun,
          iconColorLeft: WColors.yellow,
          titleLeft: "Sunrise",
          valueLeft: DateFormat("jm").format(sunrise),
          iconRight: WeatherAppIcons.moon,
          iconColorRight: WColors.purple,
          titleRight: "Sunset",
          valueRight: DateFormat("jm").format(sunset),
        ),
      ],
    );
  }
}
