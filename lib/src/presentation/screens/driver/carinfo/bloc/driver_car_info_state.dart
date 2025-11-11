import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';

class DriverCarInfoState extends Equatable {

  final int? idDriver;
  final BlocFormItem brand;
  final BlocFormItem plate;
  final BlocFormItem color;
  final Resource? response;
  final GlobalKey<FormState>? formKey;

  const DriverCarInfoState({
    this.idDriver,
    this.brand = const BlocFormItem(error: 'Ingresa el nombre'),
    this.plate = const BlocFormItem(error: 'Ingresa el apellido'),
    this.color = const BlocFormItem(error: 'Ingresa el telefono'),
    this.formKey,
    this.response,
  });

  DriverCarInfoState copyWith({
    int? idDriver,
    BlocFormItem? brand,
    BlocFormItem? plate,
    BlocFormItem? color,
    GlobalKey<FormState>? formKey,
    Resource? response
  }) {
    return DriverCarInfoState(
      idDriver: idDriver ?? this.idDriver,
      brand: brand ?? this.brand,
      plate: plate ?? this.plate,
      color: color ?? this.color,
      formKey: formKey,
      response: response
    );
  }

  @override
  List<Object?> get props => [brand, plate, color, response, idDriver];

}