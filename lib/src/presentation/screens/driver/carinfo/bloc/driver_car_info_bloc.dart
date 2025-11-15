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

  DriverCarInfoBloc(this.authUseCases, this.driverCarInfoUseCases)
    : super(DriverCarInfoState()) {
      //
      //
      //
    on<DriverCarInfoInitEvent>((event, emit) async {
      emit(state.copyWith(formKey: formKey));
      
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      
      // debugPrint('----- Auth Response User ID ----');
      // debugPrint('User ID: ${authResponse.user.id}');
      
      // IMPORTANTE: Emitir el idDriver primero
      emit(state.copyWith(
        idDriver: authResponse.user.id!,
        formKey: formKey,
      ));
      
      Resource response = await driverCarInfoUseCases.getDriverCarInfo.run(
        authResponse.user.id!,
      );
      
      // debugPrint('----- Response Type ----');
      // debugPrint('Response is Success: ${response is Success}');
      // debugPrint('Response is Error: ${response is ErrorData}');
      
      if (response is Success) {
        final driverCarInfo = response.data as DriverCarInfo;
        // debugPrint('----- driverCarInfo Bloc User ID ----');
        // debugPrint('${driverCarInfo.toJson()}');
        emit(
          state.copyWith(
            idDriver: authResponse.user.id!,
            brand: BlocFormItem(value: driverCarInfo.brand),
            plate: BlocFormItem(value: driverCarInfo.plate),
            color: BlocFormItem(value: driverCarInfo.color),
            formKey: formKey,
          ),
        );
      } else if (response is ErrorData) {
        debugPrint('----- Error Getting Driver Car Info ----');
        debugPrint('Error: ${response.message}');
        // El idDriver ya fue emitido arriba, así que está disponible
      }
    });




    on<BrandChanged>((event, emit) {
      emit(
        state.copyWith(
          brand: BlocFormItem(
            value: event.brand.value,
            error: event.brand.value.isEmpty ? 'Ingresa la marca' : null,
          ),
          formKey: formKey,
        ),
      );
    });
    on<PlateChanged>((event, emit) {
      emit(
        state.copyWith(
          plate: BlocFormItem(
            value: event.plate.value,
            error: event.plate.value.isEmpty
                ? 'Ingresa la placa del vehiculo'
                : null,
          ),
          formKey: formKey,
        ),
      );
    });
    on<ColorChanged>((event, emit) {
      emit(
        state.copyWith(
          color: BlocFormItem(
            value: event.color.value,
            error: event.color.value.isEmpty
                ? 'Ingresa el color del vehiculo'
                : null,
          ),
          formKey: formKey,
        ),
      );
    });

    on<FormSubmit>((event, emit) async {
      // LOG: Ver el idDriver antes de enviar
      // debugPrint('----- Form Submit ----');
      // debugPrint('idDriver: ${state.idDriver}');
      // debugPrint('brand: ${state.brand.value}');
      // debugPrint('plate: ${state.plate.value}');
      // debugPrint('color: ${state.color.value}');
      
      emit(state.copyWith(response: Loading(), formKey: formKey));
      Resource response = await driverCarInfoUseCases.createDriverCarInfo.run(
        DriverCarInfo(
          idDriver: state.idDriver,
          brand: state.brand.value,
          plate: state.plate.value,
          color: state.color.value,
        ),
      );
      emit(state.copyWith(response: response, formKey: formKey));
    });
  }
}
