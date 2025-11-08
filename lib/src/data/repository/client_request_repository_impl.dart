

import 'package:uber_clone/src/data/dataSource/remote/services/client_request_service.dart';
import 'package:uber_clone/src/domain/models/client_request.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/domain/models/time_and_distance_values.dart';
import 'package:uber_clone/src/domain/repository/client_request_repository.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

class ClientRequestsRepositoryImpl implements ClientRequestsRepository {
  
  ClientRequestsService clientRequestsService;

  ClientRequestsRepositoryImpl(this.clientRequestsService);
  
  @override
  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequets(
    double originLat, 
    double originLng, 
    double destinationLat, 
    double destinationLng
  ) {
    return clientRequestsService.getTimeAndDistanceClientRequets(originLat, originLng, destinationLat, destinationLng);
  }

  @override
  Future<Resource<int>> create(ClientRequest clientRequest) {
    return clientRequestsService.create(clientRequest);
  }

  @override
  Future<Resource<List<ClientRequestResponse>>> getNearbyTripRequest(double driverLat, double driverLng) {
    return clientRequestsService.getNearbyTripRequest(driverLat, driverLng);
  }

}