
import 'package:uber_clone/src/domain/repository/client_request_repository.dart';

class GetNearbyTripRequestUseCase {

  ClientRequestsRepository clientRequestsRepository;

  GetNearbyTripRequestUseCase(this.clientRequestsRepository);

  run(double driverLat, double driverLng) => clientRequestsRepository.getNearbyTripRequest(driverLat, driverLng);

}