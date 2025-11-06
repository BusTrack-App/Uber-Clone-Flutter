import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/src/domain/repository/geolocator_repository.dart';

class GetPlacemarkDataUseCase {

  GeolocatorRepository geolocatorRepository;

  GetPlacemarkDataUseCase(this.geolocatorRepository);

  run(CameraPosition cameraPosition) => geolocatorRepository.getPlacemarkData(cameraPosition);

}