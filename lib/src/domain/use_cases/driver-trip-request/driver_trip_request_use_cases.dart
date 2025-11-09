import 'package:uber_clone/src/domain/use_cases/driver-trip-request/create_driver_trip_request_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/driver-trip-request/get_driver_trip_offers_by_client_request_use_case.dart';

class DriverTripRequestUseCases {

  CreateDriverTripRequestUseCase createDriverTripRequest;
  GetDriverTripOffersByClientRequestUseCase getDriverTripOffersByClientRequest;

  DriverTripRequestUseCases({
    required this.createDriverTripRequest,
    required this.getDriverTripOffersByClientRequest,
  });

}