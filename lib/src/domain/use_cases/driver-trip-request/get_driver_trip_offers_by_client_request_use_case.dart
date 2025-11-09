
import 'package:uber_clone/src/domain/repository/driver_trip_request_repository.dart';

class GetDriverTripOffersByClientRequestUseCase {

  DriverTripRequestsRepository driverTripRequestsRepository;

  GetDriverTripOffersByClientRequestUseCase(this.driverTripRequestsRepository);

  run(int idClientRequest) => driverTripRequestsRepository.getDriverTripOffersByClientRequest(idClientRequest);

}