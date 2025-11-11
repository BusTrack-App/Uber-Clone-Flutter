
import 'package:uber_clone/src/domain/use_cases/driver-car-info/create_driver_car_info_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/driver-car-info/get_driver_car_info_use_case.dart';

class DriverCarInfoUseCases {

  CreateDriverCarInfoUseCase createDriverCarInfo;
  GetDriverCarInfoUseCase getDriverCarInfo;

  DriverCarInfoUseCases({
    required this.createDriverCarInfo,
    required this.getDriverCarInfo,
  });

}