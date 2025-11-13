import 'package:uber_clone/src/domain/repository/client_request_repository.dart';

class GetByDriverAssignedUseCase {

  ClientRequestsRepository clientRequestsRepository;

  GetByDriverAssignedUseCase(this.clientRequestsRepository);

  run(int idDriver) => clientRequestsRepository.getByDriverAssigned(idDriver);

}