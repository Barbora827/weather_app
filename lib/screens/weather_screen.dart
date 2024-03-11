import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/styles/colors.dart';
import 'package:weather_app/widgets/w_code_icons.dart';
import 'package:weather_app/widgets/w_text.dart';
import 'package:weather_app/widgets/w_app_icons.dart';
import '../bloc/weather_bloc.dart';
import '../widgets/w_display_row.dart';
import 'package:intl/intl.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherSuccess) {
                final weatherCode = state.weather.weatherConditionCode!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(50),
                    WText(
                      text: "${state.weather.areaName}",
                      size: 25,
                      weight: FontWeight.w400,
                    ),
                    const Gap(50),
                    Icon(
                      getWeatherIcon(weatherCode),
                      size: 225,
                      color: WColors.white,
                    ),
                    const Gap(15),
                    WText(
                      text: "${state.weather.temperature!.celsius!.round()}°C",
                      size: 70,
                      weight: FontWeight.w600,
                    ),
                    WText(
                      text: "${state.weather.weatherMain}",
                      size: 25,
                      weight: FontWeight.w600,
                    ),
                    const Gap(10),
                    WText(
                      text: DateFormat("E MMMM d | ")
                              .format(state.weather.date!) +
                          DateFormat("jm").format(state.weather.date!),
                      size: 18,
                      weight: FontWeight.w500,
                    ),
                    const Gap(30),
                    WDisplayRowWidget(
                      iconLeft: WeatherAppIcons.temperatire,
                      iconColorLeft: WColors.hot,
                      titleLeft: "Max Temps",
                      valueLeft: "${state.weather.tempMax!.celsius!.round()}°C",
                      iconRight: WeatherAppIcons.temperatire,
                      iconColorRight: WColors.cold,
                      titleRight: "Min Temps",
                      valueRight:
                          "${state.weather.tempMin!.celsius!.round()}°C",
                      gap: 30,
                    ),
                    WDisplayRowWidget(
                      iconLeft: WeatherAppIcons.sun,
                      iconColorLeft: WColors.sun,
                      titleLeft: "Sunrise",
                      valueLeft:
                          DateFormat("jm").format(state.weather.sunrise!),
                      iconRight: WeatherAppIcons.moon,
                      iconColorRight: WColors.moon,
                      titleRight: "Sunset",
                      valueRight:
                          DateFormat("jm").format(state.weather.sunset!),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
