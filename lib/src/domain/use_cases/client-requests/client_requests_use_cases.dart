

import 'package:uber_clone/src/domain/use_cases/client-requests/create_client_request_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/get_time_and_distance_use_case.dart';

class ClientRequestsUseCases {

  CreateClientRequestUseCase createClientRequest;
  GetTimeAndDistanceUseCase getTimeAndDistance;

  ClientRequestsUseCases({
    required this.createClientRequest,
    required this.getTimeAndDistance
  });

}