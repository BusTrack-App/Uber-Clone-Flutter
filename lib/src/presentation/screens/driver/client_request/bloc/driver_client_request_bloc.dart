import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io.dart';
import 'package:uber_clone/src/domain/models/auth_response.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/domain/models/driver_position.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/client_requests_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/driver-trip-request/driver_trip_request_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/drivers-position/drivers_position_use_cases.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/bloc/driver_client_request_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/bloc/driver_client_request_state.dart';


class DriverClientRequestsBloc extends Bloc<DriverClientRequestsEvent, DriverClientRequestsState> {

  AuthUseCases authUseCases;
  DriversPositionUseCases driversPositionUseCases;
  ClientRequestsUseCases clientRequestsUseCases;
  DriverTripRequestUseCases driverTripRequestUseCases;
  BlocSocketIO blocSocketIO;

  DriverClientRequestsBloc(this.blocSocketIO, this.clientRequestsUseCases, this.driversPositionUseCases, this.authUseCases, this.driverTripRequestUseCases): super(DriverClientRequestsState()) {

    on<InitDriverClientRequest>((event, emit) async {
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      Resource responseDriverPosition = await driversPositionUseCases.getDriverPosition.run(authResponse.user.id!);
      emit(
        state.copyWith(
          response: Loading(),
          idDriver: authResponse.user.id!,
          responseDriverPosition: responseDriverPosition
        )
      );
      add(GetNearbyTripRequest());
    });

    on<GetNearbyTripRequest>((event, emit) async{
      final responseDriverPosition = state.responseDriverPosition;
      if (responseDriverPosition is Success) {
        DriverPosition driverPosition = responseDriverPosition.data as DriverPosition;
        Resource<List<ClientRequestResponse>> response = await clientRequestsUseCases.getNearbyTripRequest.run(driverPosition.lat, driverPosition.lng);
        emit(
          state.copyWith(
            response: response,
          )
        );
      }
    });

    on<CreateDriverTripRequest>((event, emit) async {
      Resource<bool> response = await driverTripRequestUseCases.createDriverTripRequest.run(event.driverTripRequest);
      emit(
        state.copyWith(responseCreateDriverTripRequest: response)
      );
      if (response is Success) {
        add(EmitNewDriverOfferSocketIO(idClientRequest: event.driverTripRequest.idClientRequest));
      }
    });

    on<FareOfferedChange>((event, emit) {
      emit(
        state.copyWith(
          fareOffered: event.fareOffered
        )
      );
    });

    on<ListenNewClientRequestSocketIO>((event, emit) {
      if (blocSocketIO.state.socket != null) {
        blocSocketIO.state.socket?.on('created_client_request', (data) {
          add(GetNearbyTripRequest());
        });
      }
    });

    on<EmitNewDriverOfferSocketIO>((event, emit) {
      if (blocSocketIO.state.socket != null) {
        blocSocketIO.state.socket?.emit('new_driver_offer', {
          'id_client_request': event.idClientRequest
        });
      }
    });

  }

}