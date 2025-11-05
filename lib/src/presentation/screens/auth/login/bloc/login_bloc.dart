import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/models/auth_response.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_event.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_state.dart';
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthUseCases authUseCases;
  // UsersUseCases usersUseCases;
  final formKey = GlobalKey<FormState>();
  
  // LoginBloc(this.authUseCases, this.usersUseCases): super(LoginState()) {
  LoginBloc(this.authUseCases): super(LoginState()) {

    on<LoginInitEvent>((event, emit) async {
      AuthResponse? authResponse = await authUseCases.getUserSession.run();
      debugPrint('Auth Response Session: ${authResponse?.toJson()}');
      emit(state.copyWith(formKey: formKey));
      if (authResponse != null) {
        emit(
          state.copyWith(
            response: Success(authResponse),
            formKey: formKey
          )
        );
      }
    });

    on<SaveUserSession>((event, emit) async {
      await authUseCases.saveUserSession.run(event.authResponse);
    });

    on<EmailChanged>((event, emit) {
      // event.email  LO QUE EL USUARIO ESTA ESCRIBIENDO
      emit(
        state.copyWith(
          email: BlocFormItem(
            value: event.email,
            error: event.email.isEmpty ? 'Ingresa el email' : null
          ),
          formKey: formKey
        )
      );
    });

    on<PasswordChanged>((event, emit) {
      emit(
        state.copyWith(
          password: BlocFormItem(
            value: event.password,
            error: 
              event.password.isEmpty 
              ? 'Ingresa el password' 
              : event.password.length < 6
                ? 'Minimo 6 caracteres'
                : null
          ),
          formKey: formKey
        )
      );
    });

    on<FormSubmit>((event, emit) async {
      debugPrint('Email: ${ state.email.value }');
      debugPrint('Password: ${ state.password.value }');
      emit(
        state.copyWith(
          response: Loading(),
          formKey: formKey
        )
      );
      Resource response = await authUseCases.login.run( state.email.value, state.password.value );
      emit(
        state.copyWith(
          response: response,
          formKey: formKey
        )
      );
    });

    // on<UpdateNotificationToken>((event, emit) async {
    //   try {
    //     String? token = await FirebaseMessaging.instance.getToken();
    //     if (token != null) {
    //       Resource response = await usersUseCases.updateNotificationToken.run(event.id, token);
    //     }
    //   } catch (e) {
    //     print('Error generando el token $e');
    //   }
    // });

  }
}
