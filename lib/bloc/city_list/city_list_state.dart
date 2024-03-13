part of 'city_list_bloc.dart';

abstract class CityListState extends Equatable {
  const CityListState();

  @override
  List<Object> get props => [];
}

class CityListLoading extends CityListState {}

class CityListSuccess extends CityListState {
  final List<City> cities;

  const CityListSuccess(this.cities);

  @override
  List<Object> get props => [cities];
}

class CityListError extends CityListState {}
