import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/city.dart';

part 'city_list_event.dart';
part 'city_list_state.dart';

class CityListBloc extends Bloc<CityListEvent, CityListState> {
  CityListBloc() : super(CityListLoading()) {
    on<GetCities>((event, emit) async {
      emit(CityListLoading());
      try {
        List<City> cities = await _retrieveSavedCities();
        emit(CityListSuccess(cities));
      } catch (e) {
        emit(CityListError());
      }
    });

    on<RefreshCityList>((event, emit) async {
      emit(CityListLoading());

      try {
        List<City> updatedCities = await _retrieveSavedCities();
        emit(CityListSuccess(updatedCities));
      } catch (e) {
        emit(CityListError());
      }
    });

    on<RemoveCity>((event, emit) async {
      try {
        await _removeCity(event.city);
        List<City> updatedCities = await _retrieveSavedCities();
        emit(CityListSuccess(updatedCities));
      } catch (e) {
        emit(CityListError());
      }
    });
  }

  Future<List<City>> _retrieveSavedCities() async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getKeys();
    final List<City> savedCities = [];

    // Filter out cached keys from SharedPreferences
    final cityKeys =
        allKeys.where((key) => !key.contains('cached_weather')).toList();
    for (final key in cityKeys) {
      final data = prefs.getString(key);
      if (data != null) {
        final decodedData = jsonDecode(data);
        final city = City(
          name: key,
          latitude: decodedData['lat'].toString(),
          longitude: decodedData['lng'].toString(),
        );
        savedCities.add(city);
      }
    }
    return savedCities;
  }

  Future<void> _removeCity(City city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(city.name);
  }
}
