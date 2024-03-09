import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/styles/colors.dart';
import 'package:weather_app/widgets/w_text.dart';
import 'package:weather_app/widgets/w_app_icons.dart';

import '../widgets/w_display_row.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              WColors.gradientDay1,
              WColors.gradientDay2,
              WColors.gradientDay3,
            ],
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(50),
              WText(
                text: "Bessancourt, France",
                size: 25,
                weight: FontWeight.w400,
              ),
              Gap(50),
              Icon(
                WeatherAppIcons.sun,
                size: 225,
                color: WColors.white,
              ),
              Gap(20),
              WText(
                text: "10°",
                size: 60,
              ),
              WText(
                text: "Sunny",
              ),
              Gap(20),
              WText(
                text: "Friday 8th of March | 14:42",
                size: 18,
                weight: FontWeight.w500,
              ),
              Gap(30),
              WDisplayRowWidget(
                iconLeft: WeatherAppIcons.temperatire,
                iconColorLeft: WColors.hot,
                titleLeft: "Max Temps",
                valueLeft: "12°",
                iconRight: WeatherAppIcons.temperatire,
                iconColorRight: WColors.cold,
                titleRight: "Min Temps",
                valueRight: "4°",
                gap: 30,
              ),
              WDisplayRowWidget(
                iconLeft: WeatherAppIcons.sun,
                iconColorLeft: WColors.sun,
                titleLeft: "Sunrise",
                valueLeft: "6:03 AM",
                iconRight: WeatherAppIcons.moon,
                iconColorRight: WColors.moon,
                titleRight: "Sunset",
                valueRight: "8:12 PM",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
