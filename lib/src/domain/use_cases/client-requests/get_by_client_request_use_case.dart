
import 'package:uber_clone/src/domain/repository/client_request_repository.dart';

class GetByClientRequestUseCase {

  ClientRequestsRepository clientRequestsRepository;

  GetByClientRequestUseCase(this.clientRequestsRepository);

  run(int idClientRequest) => clientRequestsRepository.getByClientRequest(idClientRequest);

}
