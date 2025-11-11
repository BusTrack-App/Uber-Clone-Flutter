
import 'package:uber_clone/src/domain/models/driver_car_info.dart';
import 'package:uber_clone/src/domain/repository/driver_car_info_repository.dart';

class CreateDriverCarInfoUseCase {

  DriverCarInfoRepository driverCarInfoRepository;
  CreateDriverCarInfoUseCase(this.driverCarInfoRepository);
  run(DriverCarInfo driverCarInfo) => driverCarInfoRepository.create(driverCarInfo);
}