
import 'package:uber_clone/src/domain/models/driver_car_info.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

abstract class DriverCarInfoRepository {

  Future<Resource<bool>> create(DriverCarInfo driverCarInfo);
  Future<Resource<DriverCarInfo>> getDriverCarInfo(int idDriver);

}