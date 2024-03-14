import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';

part 'add_city_event.dart';
part 'add_city_state.dart';

class AddCityBloc extends Bloc<AddCityEvent, AddCityState> {
  AddCityBloc() : super(AddCityInitial()) {
    on<RefreshAddCityScreen>((event, emit) async {
      emit(AddCityLoading());
      final ConnectivityResult connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        emit(AddCitySuccess());
      } else {
        emit(AddCityFailure());
      }
    });
  }
}
