
import 'package:uber_clone/src/domain/models/driver_trip_request.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

abstract class DriverTripRequestsRepository {

  Future<Resource<bool>> create(DriverTripRequest driverTripRequest);
  Future<Resource<List<DriverTripRequest>>> getDriverTripOffersByClientRequest(int idClientRequest);

}