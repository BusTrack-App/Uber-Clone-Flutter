

import 'package:uber_clone/src/domain/models/time_and_distance_values.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

abstract class ClientRequestsRepository {

  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequets(
    double originLat,
    double originLng,
    double destinationLat,
    double destinationLng,
  );


}