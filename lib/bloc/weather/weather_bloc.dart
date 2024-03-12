import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/data.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(WeatherFactory weatherFactory) : super(WeatherInitial()) {
    on<GetCurrentLocationWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        WeatherFactory wFactory =
            WeatherFactory(apiKey, language: Language.ENGLISH);

        Weather weather = await wFactory.currentWeatherByLocation(
          event.position.latitude,
          event.position.longitude,
        );
        emit(WeatherSuccess(weather));
      } catch (e) {
        emit(WeatherFail());
      }
    });

    on<GetCityWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        WeatherFactory wFactory =
            WeatherFactory(apiKey, language: Language.ENGLISH);
        Weather weather =
            await wFactory.currentWeatherByCityName(event.cityName);
        emit(WeatherSuccess(weather));
      } catch (e) {
        emit(WeatherFail());
      }
    });

    on<RefreshWeather>((event, emit) async {
      emit(WeatherRefreshing());
      try {
        WeatherFactory wFactory =
            WeatherFactory(apiKey, language: Language.ENGLISH);

        final currentState = state;
        if (currentState is WeatherSuccess) {
          final refreshedWeather = await wFactory.currentWeatherByCityName(
            currentState.weather.areaName!,
          );

          emit(WeatherSuccess(refreshedWeather));
        } else {
          return;
        }
      } catch (e) {
        emit(WeatherFail());
      }
    });
  }
}
