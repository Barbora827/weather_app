import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_city_event.dart';
part 'add_city_state.dart';

class AddCityBloc extends Bloc<AddCityEvent, AddCityState> {
  AddCityBloc() : super(AddCityInitial()) {
    on<AddCityEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
