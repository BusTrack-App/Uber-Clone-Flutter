

import 'package:uber_clone/src/data/dataSource/remote/services/driver_trip_request_service.dart';
import 'package:uber_clone/src/domain/models/driver_trip_request.dart';
import 'package:uber_clone/src/domain/repository/driver_trip_request_repository.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

class DriverTripRequestsRepositoryImpl implements DriverTripRequestsRepository {
  
  DriverTripRequestsService driverTripRequestsService;

  DriverTripRequestsRepositoryImpl(this.driverTripRequestsService);

  @override
  Future<Resource<bool>> create(DriverTripRequest driverTripRequest) {
    return driverTripRequestsService.create(driverTripRequest);
  }
  
  @override
  Future<Resource<List<DriverTripRequest>>> getDriverTripOffersByClientRequest(int idClientRequest) {
    return driverTripRequestsService.getDriverTripOffersByClientRequest(idClientRequest);
  }

}