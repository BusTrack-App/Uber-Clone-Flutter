import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/data/dataSource/remote/services/auth_service.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_event.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_state.dart';
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  LoginBloc() : super(LoginState()) {
    on<LoginInitEvent>((event, emit) {
      emit(state.copyWith(formKey: formKey));
    });

    on<EmailChanged>((event, emit) {
      emit(state.copyWith(
        email: BlocFormItem(
          value: event.email,
          error: event.email.isEmpty ? 'Ingresa el email' : null,
        ),
        formKey: formKey,
      ));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(
        password: BlocFormItem(
          value: event.password,
          error: event.password.isEmpty
              ? 'Ingresa el password'
              : event.password.length < 6
                  ? 'Mínimo 6 caracteres'
                  : null,
        ),
        formKey: formKey,
      ));
    });

    on<FormSubmit>((event, emit) async {
      debugPrint('Email: ${state.email.value}');
      debugPrint('Password: ${state.password.value}');

      emit(state.copyWith(response: Loading(), formKey: formKey));

      final response = await authService.login(state.email.value, state.password.value);

      emit(state.copyWith(response: response, formKey: formKey));
    });
  }
}