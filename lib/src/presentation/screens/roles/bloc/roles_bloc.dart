import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/models/auth_response.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/presentation/screens/roles/bloc/roles_event.dart';
import 'package:uber_clone/src/presentation/screens/roles/bloc/roles_state.dart';

class RolesBloc extends Bloc<RolesEvent, RolesState> {

  AuthUseCases authUseCases;

  RolesBloc(this.authUseCases): super(RolesState()) {
    on<GetRolesList>((event, emit) async {
      AuthResponse? authResponse = await authUseCases.getUserSession.run();
      emit(
        state.copyWith(
          roles: authResponse?.user.roles
        )
      );
    });
  }

}