import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/src/domain/repository/geolocator_repository.dart';

class GetPolylineUseCase {

  GeolocatorRepository geolocatorRepository;

  GetPolylineUseCase(this.geolocatorRepository);

  run(LatLng pickUpLatLng, LatLng destinationLatLng) => geolocatorRepository.getPolyline(pickUpLatLng, destinationLatLng);
}