import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/models/driver_trip_request.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/client_requests_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/driver-trip-request/driver_trip_request_use_cases.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/client/driver_offers/bloc/client_driver_offers_event.dart';
import 'package:uber_clone/src/presentation/screens/client/driver_offers/bloc/client_driver_offers_state.dart';

class ClientDriverOffersBloc extends Bloc<ClientDriverOffersEvent, ClientDriverOffersState> {

  DriverTripRequestUseCases driverTripRequestUseCases;
  ClientRequestsUseCases clientRequestsUseCases;

  ClientDriverOffersBloc(
    this.driverTripRequestUseCases,
    this.clientRequestsUseCases,
  ) : super(ClientDriverOffersState()) {
    //
    //
    // -------- Get Driver Offers
    on<GetDriverOffers>((event, emit) async {
      emit(state.copyWith(responseDriverOffers: Loading()));
      Resource<List<DriverTripRequest>> response =
          await driverTripRequestUseCases.getDriverTripOffersByClientRequest
              .run(event.idClientRequest);
      emit(state.copyWith(responseDriverOffers: response));
    });

  }
}
