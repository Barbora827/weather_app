part of 'city_list_bloc.dart';

sealed class CityListState extends Equatable {
  const CityListState();
  
  @override
  List<Object> get props => [];
}

final class CityListInitial extends CityListState {}
