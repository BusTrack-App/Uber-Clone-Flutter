import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/models/auth_response.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/domain/models/driver_trip_request.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/client_requests_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/driver-trip-request/driver_trip_request_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/drivers-position/drivers_position_use_cases.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/bloc/driver_client_request_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/bloc/driver_client_request_state.dart';
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';

class DriverClientRequestsBloc
    extends Bloc<DriverClientRequestsEvent, DriverClientRequestsState> {
  AuthUseCases authUseCases;
  DriversPositionUseCases driversPositionUseCases;
  ClientRequestsUseCases clientRequestsUseCases;
  DriverTripRequestUseCases driverTripRequestUseCases;
  // BlocSocketIO blocSocketIO;

  DriverClientRequestsBloc(
    // this.blocSocketIO,
    this.clientRequestsUseCases,
    this.driversPositionUseCases,
    this.authUseCases,
    this.driverTripRequestUseCases,
  ) : super(DriverClientRequestsState()) {
    //
    //
    //. ------- Evento del INIT --------
    on<InitDriverClientRequest>((event, emit) async {});

    on<GetNearbyTripRequest>((event, emit) async {
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      Resource driverPositionResponse = await driversPositionUseCases
          .getDriverPosition
          .run(authResponse.user.id!);

      if (driverPositionResponse is Success) {
        final driverPosition = driverPositionResponse.data;

        Resource<List<ClientRequestResponse>> response =
            await clientRequestsUseCases.getNearbyTripRequest.run(
              driverPosition.lat,
              driverPosition.lng,
            );
        emit(
          state.copyWith(
            response: response, 
            idDriver: authResponse.user.id
          ),
        );
      }
    });

    on<CreateDriverTripRequest>((event, emit) async {
      Resource<bool> response = await driverTripRequestUseCases
          .createDriverTripRequest
          .run(event.driverTripRequest);
      emit(state.copyWith(responseCreateDriverTripRequest: response));
    });

    on<FareOfferedChange>((event, emit) {
      emit(
        state.copyWith(
          fareOffered: BlocFormItem(
            value: event.fareOffered.value,
            error: event.fareOffered.value.isEmpty ? 'Ingresa la tarifa' : null,
          ),
        ),
      );
    });
  }
}
