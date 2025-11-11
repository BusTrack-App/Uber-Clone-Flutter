
import 'package:uber_clone/src/data/dataSource/remote/services/driver_car_info_service.dart';
import 'package:uber_clone/src/domain/models/driver_car_info.dart';
import 'package:uber_clone/src/domain/repository/driver_car_info_repository.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

class DriverCarInfoRepositoryImpl implements DriverCarInfoRepository{

  DriverCarInfoService driverCarInfoService;

  DriverCarInfoRepositoryImpl(this.driverCarInfoService);

  @override
  Future<Resource<bool>> create(DriverCarInfo driverCarInfo) {
    return driverCarInfoService.create(driverCarInfo);
  }

  @override
  Future<Resource<DriverCarInfo>> getDriverCarInfo(int idDriver) {
    return driverCarInfoService.getDriverCarInfo(idDriver);
  }



}