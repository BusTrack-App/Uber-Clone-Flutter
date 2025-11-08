import 'package:uber_clone/src/data/dataSource/remote/services/driver_position_service.dart';
import 'package:uber_clone/src/domain/models/driver_position.dart';
import 'package:uber_clone/src/domain/repository/drivers_position_repository.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

class DriversPositionRepositoryImpl implements DriverPositionRepository {
  DriversPositionService driversPositionService;

  DriversPositionRepositoryImpl(this.driversPositionService);

  @override
  Future<Resource<bool>> create(DriverPosition driverPosition) {
    return driversPositionService.create(driverPosition);
  }

  @override
  Future<Resource<bool>> delete(int idDriver) {
    return driversPositionService.delete(idDriver);
  }

  @override
  Future<Resource<DriverPosition>> getDriverPosition(int idDriver) {
    return driversPositionService.getDriverPosition(idDriver);
  }
}
