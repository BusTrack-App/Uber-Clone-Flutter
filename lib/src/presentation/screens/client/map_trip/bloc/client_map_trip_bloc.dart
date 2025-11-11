import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/client_requests_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/geolocator_use_cases.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/client/map_trip/bloc/client_map_trip_event.dart';
import 'package:uber_clone/src/presentation/screens/client/map_trip/bloc/client_map_trip_state.dart';


class ClientMapTripBloc extends Bloc<ClientMapTripEvent, ClientMapTripState> {
  Timer? timer;
  BlocSocketIO blocSocketIO;
  ClientRequestsUseCases clientRequestsUseCases;
  GeolocatorUseCases geolocatorUseCases;
  AuthUseCases authUseCases;

  ClientMapTripBloc(this.blocSocketIO, this.clientRequestsUseCases,
      this.geolocatorUseCases, this.authUseCases)
      : super(ClientMapTripState()) {
    //
    //
    //
    on<InitClientMapTripEvent>((event, emit) async {
    });

    on<GetClientRequest>((event, emit) async {
      Resource response = await clientRequestsUseCases.getByClientRequest.run(event.idClientRequest);
      emit(state.copyWith(responseGetClientRequest: response));
      // if (response is Success) {
      //   final data = response.data as ClientRequestResponse;
      //   emit(state.copyWith(clientRequestResponse: data));
      //   add(ListenUpdateStatusClientRequestSocketIO());
      // }
    });

  }
}

