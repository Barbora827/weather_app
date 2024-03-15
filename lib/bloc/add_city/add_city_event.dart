part of 'add_city_bloc.dart';

sealed class AddCityEvent extends Equatable {
  const AddCityEvent();

  @override
  List<Object> get props => [];
}

class GetAddCityScreen extends AddCityEvent {}

class SaveCity extends AddCityEvent {
  final String city;

  const SaveCity(this.city);

  @override
  List<Object> get props => [city];
}
