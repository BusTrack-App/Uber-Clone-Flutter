import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uber_clone/src/domain/models/auth_response.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/users/users_use_case.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/profile/update/bloc/profile_update_event.dart';
import 'package:uber_clone/src/presentation/screens/profile/update/bloc/profile_update_state.dart';
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';


class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {

  AuthUseCases authUseCases;
  UsersUseCases usersUseCases;
  final formKey = GlobalKey<FormState>();

  ProfileUpdateBloc(this.usersUseCases, this.authUseCases): super(ProfileUpdateState()) {
    on<ProfileUpdateInitEvent>((event, emit) {
      emit(
        state.copyWith(
          id: event.user?.id,
          name: BlocFormItem(value: event.user?.name ?? ''),
          lastname: BlocFormItem(value: event.user?.lastname ?? ''),
          phone: BlocFormItem(value: event.user?.phone ?? ''),
          formKey: formKey
        )
      );
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
    on<LastNameChanged>((event, emit) {
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
    on<PickImage>((event, emit) async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) { // SI EL USUARIO SELECCIONO UNA IMAGEN
        emit(
           state.copyWith(
            image: File(image.path),
            formKey: formKey
          )
        );
      }
    });
    on<TakePhoto>((event, emit) async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) { // SI EL USUARIO SELECCIONO UNA IMAGEN
        emit(
           state.copyWith(
            image: File(image.path),
            formKey: formKey
          )
        );
      }
    });
    on<UpdateUserSession>((event, emit) async {
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      authResponse.user.name = event.user.name;
      authResponse.user.lastname = event.user.lastname;
      authResponse.user.phone = event.user.phone;
      authResponse.user.image = event.user.image;
      await authUseCases.saveUserSession.run(authResponse);
    });
    on<FormSubmit>((event, emit) async {
      debugPrint('Name: ${state.name.value}');
      debugPrint('LastName: ${state.lastname.value}');
      debugPrint('Phone: ${state.phone.value}');
      emit(
        state.copyWith(
          response: Loading(),
          formKey: formKey
        )
      );
      Resource response = await usersUseCases.update.run(state.id, state.toUser(), state.image);
      emit(
        state.copyWith(
          response: response,
          formKey: formKey
        )
      );
    });
  }

}