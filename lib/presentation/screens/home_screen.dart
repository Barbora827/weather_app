import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/presentation/styles/colors.dart';
import 'package:weather_app/presentation/widgets/w_code_icons.dart';
import 'package:weather_app/presentation/widgets/weather_display.dart';
import '../../bloc/weather/weather_bloc.dart';
import '../widgets/w_no_internet_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          // If online
          if (state is WeatherSuccess) {
            final weatherCode = state.weather.weatherConditionCode!;
            return WeatherDisplay(
                canNavigateBack: false,
                areaName: "${state.weather.areaName}",
                temperature: "${state.weather.temperature!.celsius!.round()}°C",
                icon: getWeatherIcon(weatherCode),
                weather: "${state.weather.weatherMain}",
                date: state.weather.date!,
                tempMax: "${state.weather.tempMax!.celsius!.round()}°C",
                tempMin: "${state.weather.tempMin!.celsius!.round()}°C",
                sunset: state.weather.sunset!,
                sunrise: state.weather.sunrise!);
          } else {
            // If offline
            return FutureBuilder<String?>(
              future: _getCachedWeather(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final Map<String, dynamic> savedWeatherMap =
                      jsonDecode(snapshot.data!);
                  final Weather cachedWeather = Weather(savedWeatherMap);
                  final weatherCode = cachedWeather.weatherConditionCode!;
                  return WeatherDisplay(
                      canNavigateBack: false,
                      areaName: "${cachedWeather.areaName}",
                      temperature:
                          "${cachedWeather.temperature!.celsius!.round()}°C",
                      icon: getWeatherIcon(weatherCode),
                      weather: "${cachedWeather.weatherMain}",
                      date: cachedWeather.date!,
                      tempMax: "${cachedWeather.tempMax!.celsius!.round()}°C",
                      tempMin: "${cachedWeather.tempMin!.celsius!.round()}°C",
                      sunset: cachedWeather.sunset!,
                      sunrise: cachedWeather.sunrise!);
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: WNoInternetDisplay(
                      cache: true,
                      onTap: () {},
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Future<String?> _getCachedWeather() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cached_weather');
  }
}
