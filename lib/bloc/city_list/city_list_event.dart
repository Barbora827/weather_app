part of 'city_list_bloc.dart';

abstract class CityListEvent extends Equatable {
  const CityListEvent();

  @override
  List<Object> get props => [];
}

class GetCities extends CityListEvent {
  final List<City> cities;

  const GetCities({required this.cities});

  @override
  List<Object> get props => [cities];
}

class RefreshCityList extends CityListEvent {}
