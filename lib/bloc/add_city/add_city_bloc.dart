import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/presentation/screens/add_city_screen.dart';

part 'add_city_event.dart';
part 'add_city_state.dart';

class AddCityBloc extends Bloc<AddCityEvent, AddCityState> {
  final GeocodingService geoService;

  AddCityBloc(this.geoService) : super(AddCityInitial()) {
    on<GetAddCityScreen>((event, emit) async {
      emit(AddCityLoading());
      final ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        emit(AddCityScreenSuccess());
      } else {
        emit(AddCityNoInternet());
      }
    });

    on<SaveCity>((event, emit) async {
      await _saveCity(event, emit);
    });
  }

  Future<void> _saveCity(SaveCity event, Emitter<AddCityState> emit) async {
    final address = event.city;
    final coordinates = await geoService.getCoordinates(address);

    if (coordinates != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = jsonEncode(coordinates);
      await prefs.setString(address, data);
      emit(CitySaved());
    } else {
      emit(CitySaveFailed());
    }
    emit(AddCityScreenSuccess());
  }
}
