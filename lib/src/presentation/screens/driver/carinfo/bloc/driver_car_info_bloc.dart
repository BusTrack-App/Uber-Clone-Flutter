
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/models/auth_response.dart';
import 'package:uber_clone/src/domain/models/driver_car_info.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/driver-car-info/driver_car_info_use_cases.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/driver/carinfo/bloc/driver_car_info_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/carinfo/bloc/driver_car_info_state.dart';
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';


class DriverCarInfoBloc extends Bloc<DriverCarInfoEvent, DriverCarInfoState> {

  AuthUseCases authUseCases;
  DriverCarInfoUseCases driverCarInfoUseCases;
  final formKey = GlobalKey<FormState>();

  DriverCarInfoBloc(this.authUseCases, this.driverCarInfoUseCases): super(DriverCarInfoState()) {
    
    on<DriverCarInfoInitEvent>((event, emit) async {
      emit(
        state.copyWith(
          formKey: formKey
        )
      );
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      Resource response = await driverCarInfoUseCases.getDriverCarInfo.run(authResponse.user.id!);
      if (response is Success) {
        final driverCarInfo = response.data as DriverCarInfo;
         emit(
          state.copyWith(
            idDriver: authResponse.user.id!,
            brand: BlocFormItem(
              value: driverCarInfo.brand
            ),
            plate: BlocFormItem(
              value: driverCarInfo.plate
            ),
            color: BlocFormItem(
              value: driverCarInfo.color
            ),
            formKey: formKey
          )
        );
      }
     
    });
    on<BrandChanged>((event, emit) {
      emit(
        state.copyWith(
          brand: BlocFormItem(
            value: event.brand.value,
            error: event.brand.value.isEmpty ? 'Ingresa la marca' : null
          ),
          formKey: formKey
        )
      );
    });
    on<PlateChanged>((event, emit) {
      emit(
        state.copyWith(
          plate: BlocFormItem(
            value: event.plate.value,
            error: event.plate.value.isEmpty ? 'Ingresa la placa del vehiculo' : null
          ),
          formKey: formKey
        )
      );
    });
    on<ColorChanged>((event, emit) {
      emit(
        state.copyWith(
          color: BlocFormItem(
            value: event.color.value,
            error: event.color.value.isEmpty ? 'Ingresa el color del vehiculo' : null
          ),
          formKey: formKey
        )
      );
    });
    
    on<FormSubmit>((event, emit) async {
      emit(
        state.copyWith(
          response: Loading(),
          formKey: formKey
        )
      );
      Resource response = await driverCarInfoUseCases.createDriverCarInfo.run(
        DriverCarInfo(
          idDriver: state.idDriver,
          brand: state.brand.value, 
          plate: state.plate.value, 
          color: state.color.value
        )
      );
      emit(
        state.copyWith(
          response: response,
          formKey: formKey
        )
      );
    });
  }

}