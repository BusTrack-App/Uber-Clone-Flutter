

import 'package:uber_clone/src/domain/models/driver_position.dart';
import 'package:uber_clone/src/domain/repository/drivers_position_repository.dart';

class CreateDriverPositionUseCase {

  DriverPositionRepository driverPositionRepository;

  CreateDriverPositionUseCase(this.driverPositionRepository);

  run(DriverPosition driverPosition) => driverPositionRepository.create(driverPosition);

}