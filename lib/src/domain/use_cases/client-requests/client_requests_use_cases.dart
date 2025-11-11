

import 'package:uber_clone/src/domain/use_cases/client-requests/create_client_request_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/get_by_client_request_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/get_nearby_trip_request_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/get_time_and_distance_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/update_driver_assigned_use_case.dart';

class ClientRequestsUseCases {

  CreateClientRequestUseCase createClientRequest;
  GetTimeAndDistanceUseCase getTimeAndDistance;
  GetNearbyTripRequestUseCase getNearbyTripRequest;
  GetByClientRequestUseCase getByClientRequest;

  // Updates
  UpdateDriverAssignedUseCase updateDriverAssigned;



  ClientRequestsUseCases({
    required this.createClientRequest,
    required this.getTimeAndDistance,
    required this.getNearbyTripRequest,
    required this.updateDriverAssigned,
    required this.getByClientRequest,
  });

}