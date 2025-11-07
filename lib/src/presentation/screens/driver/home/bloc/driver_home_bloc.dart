import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/presentation/screens/driver/home/bloc/driver_home_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/home/bloc/driver_home_state.dart';

class DriverHomeBloc extends Bloc<DriverHomeEvent, DriverHomeState> {

  AuthUseCases authUseCases;

  DriverHomeBloc(this.authUseCases): super(DriverHomeState()) {
    on<ChangeDrawerPage>((event, emit) {
      emit(
        state.copyWith(
          pageIndex: event.pageIndex
        )
      );
    });

    on<Logout>((event, emit) async {
      await authUseCases.logout.run();
    });
  }

}