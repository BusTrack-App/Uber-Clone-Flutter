
import 'package:uber_clone/src/domain/repository/client_request_repository.dart';

class GetByClientAssignedUseCase {

  ClientRequestsRepository clientRequestsRepository;

  GetByClientAssignedUseCase(this.clientRequestsRepository);

  run(int idClient) => clientRequestsRepository.getByClientAssigned(idClient);

}