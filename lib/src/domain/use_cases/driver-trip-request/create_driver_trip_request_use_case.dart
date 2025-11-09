
import 'package:uber_clone/src/domain/models/driver_trip_request.dart';
import 'package:uber_clone/src/domain/repository/driver_trip_request_repository.dart';

class CreateDriverTripRequestUseCase {

  DriverTripRequestsRepository driverTripRequestsRepository;

  CreateDriverTripRequestUseCase(this.driverTripRequestsRepository);

  run(DriverTripRequest driverTripRequest) => driverTripRequestsRepository.create(driverTripRequest);
}