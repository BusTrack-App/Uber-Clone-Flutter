
import 'package:uber_clone/src/domain/repository/client_request_repository.dart';

class GetTimeAndDistanceUseCase {

  ClientRequestsRepository clientRequestsRepository;

  GetTimeAndDistanceUseCase(this.clientRequestsRepository);

  run(
    double originLat, 
    double originLng, 
    double destinationLat, 
    double destinationLng
  ) => clientRequestsRepository.getTimeAndDistanceClientRequets(originLat, originLng, destinationLat, destinationLng);

}