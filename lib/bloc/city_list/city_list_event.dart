part of 'city_list_bloc.dart';

abstract class CityListEvent extends Equatable {
  const CityListEvent();

  @override
  List<Object> get props => [];
}

class GetCities extends CityListEvent {}

class RefreshCityList extends CityListEvent {}

class LoadMoreCities extends CityListEvent {}

class ScrollListener extends CityListEvent {}

class RemoveCity extends CityListEvent {
  final City city;

  const RemoveCity(this.city);

  @override
  List<City> get props => [city];
}
