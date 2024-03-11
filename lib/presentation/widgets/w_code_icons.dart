import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/w_app_icons.dart';

enum WeatherCode {
  thunderstorm,
  drizzle,
  rain,
  snow,
  fog,
  clear,
  partiallyClear,
  clouds,
}

// Map weather codes to corresponding icons
final Map<WeatherCode, IconData> weatherIcons = {
  WeatherCode.thunderstorm: WeatherAppIcons.cloud_flash,
  WeatherCode.drizzle: WeatherAppIcons.drizzle_inv,
  WeatherCode.rain: WeatherAppIcons.rain,
  WeatherCode.snow: WeatherAppIcons.snow_heavy,
  WeatherCode.fog: WeatherAppIcons.fog,
  WeatherCode.clear: WeatherAppIcons.sun,
  WeatherCode.partiallyClear: WeatherAppIcons.cloud_sun,
  WeatherCode.clouds: WeatherAppIcons.clouds,
};

// Get the weather icon based on weather code
IconData getWeatherIcon(int weatherCode) {
  WeatherCode code = _mapWeatherCode(weatherCode);
  return weatherIcons[code] ?? WeatherAppIcons.na;
}

// Map weather code to the enum
WeatherCode _mapWeatherCode(int code) {
  if (code >= 200 && code <= 232) {
    return WeatherCode.thunderstorm;
  } else if (code >= 300 && code <= 321) {
    return WeatherCode.drizzle;
  } else if (code >= 500 && code <= 531) {
    return WeatherCode.rain;
  } else if (code >= 600 && code <= 622) {
    return WeatherCode.snow;
  } else if (code == 741) {
    return WeatherCode.fog;
  } else if (code == 800) {
    return WeatherCode.clear;
  } else if (code == 801 || code == 802) {
    return WeatherCode.partiallyClear;
  } else {
    return WeatherCode.clouds;
  }
}
