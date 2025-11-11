
import 'package:uber_clone/src/domain/repository/driver_car_info_repository.dart';

class GetDriverCarInfoUseCase {

  DriverCarInfoRepository driverCarInfoRepository;
  GetDriverCarInfoUseCase(this.driverCarInfoRepository);
  run(int idDriver) => driverCarInfoRepository.getDriverCarInfo(idDriver);
}