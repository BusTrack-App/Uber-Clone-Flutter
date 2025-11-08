
import 'package:uber_clone/src/domain/models/client_request.dart';
import 'package:uber_clone/src/domain/repository/client_request_repository.dart';

class CreateClientRequestUseCase {

  ClientRequestsRepository clientRequestsRepository;

  CreateClientRequestUseCase(this.clientRequestsRepository);

  run(ClientRequest clientRequest) => clientRequestsRepository.create(clientRequest);

}