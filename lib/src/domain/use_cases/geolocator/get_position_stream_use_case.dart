import 'package:uber_clone/src/domain/repository/geolocator_repository.dart';

class GetPositionStreamUseCase {

  GeolocatorRepository geolocatorRepository;

  GetPositionStreamUseCase(this.geolocatorRepository);

  run() => geolocatorRepository.getPositionStream();

}