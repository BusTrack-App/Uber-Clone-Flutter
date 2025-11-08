
import 'package:uber_clone/src/domain/use_cases/drivers-position/create_driver_position_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/drivers-position/delete_driver_position_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/drivers-position/get_driver_position_use_case.dart';

class DriversPositionUseCases {

  CreateDriverPositionUseCase createDriverPosition;
  DeleteDriverPositionUseCase deleteDriverPosition;
  GetDriverPositionUseCase getDriverPosition;

  DriversPositionUseCases({
    required this.createDriverPosition,
    required this.deleteDriverPosition,
    required this.getDriverPosition,
  });

}