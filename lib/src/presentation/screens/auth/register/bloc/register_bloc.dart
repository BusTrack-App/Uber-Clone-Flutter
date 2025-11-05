import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/presentation/screens/auth/register/bloc/register_event.dart';
import 'package:uber_clone/src/presentation/screens/auth/register/bloc/register_state.dart';
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final formKey = GlobalKey<FormState>();

  RegisterBloc(locator) : super(RegisterState()) {
    on<RegisterInitEvent>((event, emit) {
      emit(state.copyWith( formKey: formKey ));
    });

    on<NameChanged>((event, emit) {
      emit(
        state.copyWith(
          name: BlocFormItem(
            value: event.name.value,
            error: event.name.value.isEmpty ? 'Ingresa el nombre' : null
          ),
          formKey: formKey
        )
      );
    });

    on<LastnameChanged>((event, emit) {
      emit(
        state.copyWith(
          lastname: BlocFormItem(
            value: event.lastname.value,
            error: event.lastname.value.isEmpty ? 'Ingresa el apellido' : null
          ),
          formKey: formKey
        )
      );
    });

    on<EmailChanged>((event, emit) {
      emit(
        state.copyWith(
          email: BlocFormItem(
            value: event.email.value,
            error: event.email.value.isEmpty ? 'Ingresa el email' : null
          ),
          formKey: formKey
        )
      );
    });

    on<PhoneChanged>((event, emit) {
      emit(
        state.copyWith(
          phone: BlocFormItem(
            value: event.phone.value,
            error: event.phone.value.isEmpty ? 'Ingresa el telefono' : null
          ),
          formKey: formKey
        )
      );
    });

    on<PasswordChanged>((event, emit) {
      emit(
        state.copyWith(
          password: BlocFormItem(
            value: event.password.value,
            error: event.password.value.isEmpty 
              ? 'Ingresa el Password' 
              : event.password.value.length < 6 
                ? 'Mas de 6 caracteres' 
                : null
          ),
          formKey: formKey
        )
      );
    });

    on<ConfirmPasswordChanged>((event, emit) {
      emit(
        state.copyWith(
          confirmPassword: BlocFormItem(
            value: event.confirmPassword.value,
            error: event.confirmPassword.value.isEmpty 
              ? 'Confirma el password' 
              : event.confirmPassword.value.length < 6 
                ? 'Mas de 6 caracteres' 
                : event.confirmPassword.value != state.password.value 
                  ? 'Los password no coinciden'
                  : null
          ),
          formKey: formKey
        )
      );
    });

    on<FormSubmit>((event, emit) {
      debugPrint('Name: ${state.name.value}');
      debugPrint('LastName: ${state.lastname.value}');
      debugPrint('email: ${state.email.value}');
      debugPrint('phone: ${state.phone.value}');
      debugPrint('password: ${state.password.value}');
      debugPrint('confirmPassword: ${state.confirmPassword.value}');
    });

    on<FormReset>((event, emit) {
      state.formKey?.currentState?.reset();
    });
  }
}