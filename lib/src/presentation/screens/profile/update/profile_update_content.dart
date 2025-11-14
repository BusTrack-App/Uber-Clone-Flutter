import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/models/user.dart';
import 'package:uber_clone/src/presentation/screens/profile/update/bloc/profile_update_bloc.dart';
import 'package:uber_clone/src/presentation/screens/profile/update/bloc/profile_update_event.dart';
import 'package:uber_clone/src/presentation/screens/profile/update/bloc/profile_update_state.dart';
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';
import 'package:uber_clone/src/presentation/utils/gallery_or_photo_dialog.dart';
import 'package:uber_clone/src/presentation/widgets/custom_button.dart';
import 'package:uber_clone/src/presentation/widgets/custom_text_field.dart';
import 'package:uber_clone/src/presentation/widgets/default_icon_back.dart';
import 'package:uber_clone/src/presentation/widgets/default_image_url.dart';
import 'package:uber_clone/src/presentation/utils/colors.dart';

class ProfileUpdateContent extends StatelessWidget {
  final User? user;
  final ProfileUpdateState state;

  const ProfileUpdateContent(this.state, this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Stack(
        children: [
          Column(
            children: [
              _headerProfile(context),
              const Spacer(),
              _submitButton(context),
              const SizedBox(height: 35),
            ],
          ),
          _cardUserInfo(context),
          DefaultIconBack(margin: EdgeInsets.only(top: 60, left: 30)),
        ],
      ),
    );
  }

  // === HEADER CON GRADIENTE ===
  Widget _headerProfile(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 70),
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: AppColors.yellow
      ),
      child: const Text(
        'ACTUALIZAR PERFIL',
        style: TextStyle(
          color: AppColors.backgroundLight,
          fontWeight: FontWeight.bold,
          fontSize: 19,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  // === TARJETA DE EDICIÓN ===
  Widget _cardUserInfo(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 35, right: 35, top: 150),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Card(
        color: AppColors.background,
        surfaceTintColor: AppColors.backgroundLight,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              _imagePicker(context),
              const SizedBox(height: 20),
              _textFieldName(context),
              const SizedBox(height: 15),
              _textFieldLastName(context),
              const SizedBox(height: 15),
              _textFieldPhone(context),
            ],
          ),
        ),
      ),
    );
  }

  // === IMAGEN DE PERFIL (con soporte BLoC + DefaultImageUrl) ===
  Widget _imagePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GalleryOrPhotoDialog(
          context,
          () => context.read<ProfileUpdateBloc>().add(PickImage()),
          () => context.read<ProfileUpdateBloc>().add(TakePhoto()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: state.image != null
            ? _buildCircularImage(FileImage(state.image!))
            : DefaultImageUrl(
                url: user?.image,
                width: 115,
              ),
      ),
    );
  }

  Widget _buildCircularImage(ImageProvider imageProvider) {
    return Container(
      width: 115,
      height: 115,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // === CAMPOS DE TEXTO ===
  Widget _textFieldName(BuildContext context) {
    return CustomTextField(
      text: 'Nombre',
      icon: Icons.person,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      backgroundColor: AppColors.greyLight,
      initialValue: user?.name,
      onChanged: (text) {
        context.read<ProfileUpdateBloc>().add(NameChanged(name: BlocFormItem(value: text)));
      },
      validator: (value) => state.name.error,
    );
  }

  Widget _textFieldLastName(BuildContext context) {
    return CustomTextField(
      text: 'Apellido',
      icon: Icons.person_outline,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      backgroundColor: AppColors.greyLight,
      initialValue: user?.lastname,
      onChanged: (text) {
        context.read<ProfileUpdateBloc>().add(LastNameChanged(lastname: BlocFormItem(value: text)));
      },
      validator: (value) => state.lastname.error,
    );
  }

  Widget _textFieldPhone(BuildContext context) {
    return CustomTextField(
      text: 'Teléfono',
      icon: Icons.phone,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      backgroundColor: AppColors.greyLight,
      initialValue: user?.phone,
      onChanged: (text) {
        context.read<ProfileUpdateBloc>().add(PhoneChanged(phone: BlocFormItem(value: text)));
      },
      validator: (value) => state.phone.error,
    );
  }

  // === BOTÓN DE ACTUALIZAR ===
  Widget _submitButton(BuildContext context) {
    return CustomButton(
      text: 'ACTUALIZAR USUARIO',
      iconData: Icons.save,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      onPressed: () {
        if (state.formKey?.currentState?.validate() ?? false) {
          context.read<ProfileUpdateBloc>().add(FormSubmit());
        }
      },
    );
  }
}