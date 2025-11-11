import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io.dart';
import 'package:uber_clone/src/domain/models/driver_trip_request.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/client_requests_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/driver-trip-request/driver_trip_request_use_cases.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/client/driver_offers/bloc/client_driver_offers_event.dart';
import 'package:uber_clone/src/presentation/screens/client/driver_offers/bloc/client_driver_offers_state.dart';

class ClientDriverOffersBloc
    extends Bloc<ClientDriverOffersEvent, ClientDriverOffersState> {
  BlocSocketIO blocSocketIO;
  DriverTripRequestUseCases driverTripRequestUseCases;
  ClientRequestsUseCases clientRequestsUseCases;

  ClientDriverOffersBloc(
    this.blocSocketIO,
    this.driverTripRequestUseCases,
    this.clientRequestsUseCases,
  ) : super(ClientDriverOffersState()) {
    //
    //
    // -------- Get Driver Offers
    on<GetDriverOffers>((event, emit) async {
      Resource<List<DriverTripRequest>> response =
          await driverTripRequestUseCases.getDriverTripOffersByClientRequest
              .run(event.idClientRequest);
      emit(state.copyWith(responseDriverOffers: response));
    });

    on<ListenNewDriverOfferSocketIO>((event, emit) {
      if (blocSocketIO.state.socket != null) {
        blocSocketIO.state.socket?.on(
          'created_driver_offer/${event.idClientRequest}',
          (data) {
            debugPrint('Escuchando el evento socket');
            add(GetDriverOffers(idClientRequest: event.idClientRequest));
            debugPrint('created_driver_offer/${event.idClientRequest}');
          },
        );
      }
    });

    on<AssignDriver>((event, emit) async {
      Resource<bool> response = await clientRequestsUseCases.updateDriverAssigned.run(event.idClientRequest, event.idDriver, event.fareAssigned);
      emit(
        state.copyWith(
          responseAssignDriver: response
        )
      );
      // if (response is Success) {
      //   add(EmitNewClientRequestSocketIO(idClientRequest: event.idClientRequest));
      //   add(EmitNewDriverAssignedSocketIO(
      //     idClientRequest: event.idClientRequest,
      //     idDriver: event.idDriver
      //   ));
      // }
    });
  }
}
