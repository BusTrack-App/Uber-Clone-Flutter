
import 'package:uber_clone/src/domain/repository/client_request_repository.dart';

class UpdateDriverRatingUseCase {

  ClientRequestsRepository clientRequestsRepository;

  UpdateDriverRatingUseCase(this.clientRequestsRepository);

  run(int idClientRequest, double rating) => clientRequestsRepository.updateDriverRating(idClientRequest, rating);

}