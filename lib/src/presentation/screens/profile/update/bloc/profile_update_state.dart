import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/src/domain/models/user.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';

class ProfileUpdateState extends Equatable {

  final int id;
  final BlocFormItem name;
  final BlocFormItem lastname;
  final BlocFormItem phone;
  final Resource? response;
  final File? image;
  final GlobalKey<FormState>? formKey;

  const ProfileUpdateState({
    this.id = 0,
    this.name = const BlocFormItem(error: 'Ingresa el nombre'),
    this.lastname = const BlocFormItem(error: 'Ingresa el apellido'),
    this.phone = const BlocFormItem(error: 'Ingresa el telefono'),
    this.formKey,
    this.response,
    this.image
  });

  toUser() => User(
    name: name.value, 
    lastname: lastname.value, 
    phone: phone.value
  );

  ProfileUpdateState copyWith({
    int? id,
    BlocFormItem? name,
    BlocFormItem? lastname,
    BlocFormItem? phone,
    File? image,
    GlobalKey<FormState>? formKey,
    Resource? response
  }) {
    return ProfileUpdateState(
      id: id ?? this.id,
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      formKey: formKey,
      response: response
    );
  }

  @override
  List<Object?> get props => [id, name, lastname, phone, response, image];

}