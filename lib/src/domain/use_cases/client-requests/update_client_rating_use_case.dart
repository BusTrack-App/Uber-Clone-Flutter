
import 'package:uber_clone/src/domain/repository/client_request_repository.dart';

class UpdateClientRatingUseCase {

  ClientRequestsRepository clientRequestsRepository;

  UpdateClientRatingUseCase(this.clientRequestsRepository);

  run(int idClientRequest, double rating) => clientRequestsRepository.updateClientRating(idClientRequest, rating);

}