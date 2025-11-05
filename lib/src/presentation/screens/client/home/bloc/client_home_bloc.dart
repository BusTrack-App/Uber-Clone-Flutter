import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/presentation/screens/client/home/bloc/client_home_event.dart';
import 'package:uber_clone/src/presentation/screens/client/home/bloc/client_home_state.dart';

class ClientHomeBloc extends Bloc<ClientHomeEvent, ClientHomeState> {

  AuthUseCases authUseCases;

  ClientHomeBloc(this.authUseCases): super(ClientHomeState()) {
    on<ChangeDrawerPage>((event, emit) {
      emit(
        state.copyWith(
          pageIndex: event.pageIndex
        )
      );
    });

    // on<Logout>((event, emit) async {
    //   await authUseCases.logout.run();
    // });
  }

}