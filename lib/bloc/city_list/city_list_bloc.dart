import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'city_list_event.dart';
part 'city_list_state.dart';

class CityListBloc extends Bloc<CityListEvent, CityListState> {
  CityListBloc() : super(CityListInitial()) {
    on<CityListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
