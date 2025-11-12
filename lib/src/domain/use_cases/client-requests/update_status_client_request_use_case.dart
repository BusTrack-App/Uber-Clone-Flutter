
import 'package:uber_clone/src/domain/models/status_trip.dart';
import 'package:uber_clone/src/domain/repository/client_request_repository.dart';

class UpdateStatusClientRequestUseCase {

  ClientRequestsRepository clientRequestsRepository;

  UpdateStatusClientRequestUseCase(this.clientRequestsRepository);

  run(int idClientRequest, StatusTrip statusTrip) => clientRequestsRepository.updateStatus(idClientRequest, statusTrip);

}