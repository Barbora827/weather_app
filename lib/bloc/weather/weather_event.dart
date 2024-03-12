part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentLocationWeather extends WeatherEvent {
  final Position position;

  const GetCurrentLocationWeather(this.position);

  @override
  List<Object> get props => [position];
}

class GetCityWeather extends WeatherEvent {
  final String cityName;

  const GetCityWeather({required this.cityName});

  @override
  List<Object> get props => [cityName];
}

class RefreshWeather extends WeatherEvent {}
