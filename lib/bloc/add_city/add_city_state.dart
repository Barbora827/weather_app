part of 'add_city_bloc.dart';

sealed class AddCityState extends Equatable {
  const AddCityState();
  
  @override
  List<Object> get props => [];
}

final class AddCityInitial extends AddCityState {}
