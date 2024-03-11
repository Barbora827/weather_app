import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/data/data.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/presentation/styles/colors.dart';
import 'package:weather_app/presentation/widgets/w_code_icons.dart';
import 'package:weather_app/presentation/widgets/w_text.dart';
import 'package:weather_app/presentation/widgets/w_app_icons.dart';
import '../../bloc/weather/weather_bloc.dart';
import '../widgets/w_display_row.dart';
import 'package:intl/intl.dart';

class CityViewScreen extends StatelessWidget {
  final String cityName;

  const CityViewScreen({
    super.key,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: WColors.getTimeBasedGradient(currentHour)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: BlocProvider(
          create: (context) => WeatherBloc(WeatherFactory(apiKey))
            ..add(GetCityWeather(cityName: cityName)),
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherSuccess) {
                final weatherCode = state.weather.weatherConditionCode!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(35),
                    WText(
                      text: cityName,
                      size: 25,
                      weight: FontWeight.w400,
                    ),
                    const Gap(30),
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
                    const Gap(50),
                    WDisplayRowWidget(
                      iconLeft: WeatherAppIcons.temperatire,
                      iconColorLeft: WColors.red,
                      titleLeft: "Max Temps",
                      valueLeft: "${state.weather.tempMax!.celsius!.round()}°C",
                      iconRight: WeatherAppIcons.temperatire,
                      iconColorRight: WColors.lightBlue,
                      titleRight: "Min Temps",
                      valueRight:
                          "${state.weather.tempMin!.celsius!.round()}°C",
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
                      valueLeft:
                          DateFormat("jm").format(state.weather.sunrise!),
                      iconRight: WeatherAppIcons.moon,
                      iconColorRight: WColors.purple,
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
