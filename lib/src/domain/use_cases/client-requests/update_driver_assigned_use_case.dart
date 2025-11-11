import 'package:uber_clone/src/domain/repository/client_request_repository.dart';

class UpdateDriverAssignedUseCase {
  ClientRequestsRepository clientRequestsRepository;

  UpdateDriverAssignedUseCase(this.clientRequestsRepository);

  run(int idClientRequest, int idDriver, double fareAssigned) =>
      clientRequestsRepository.updateDriverAssigned(
        idClientRequest,
        idDriver,
        fareAssigned,
      );
}
