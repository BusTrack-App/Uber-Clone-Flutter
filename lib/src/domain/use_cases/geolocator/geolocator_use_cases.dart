
import 'package:uber_clone/src/domain/use_cases/geolocator/create_marker_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/find_position_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/get_marker_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/get_placemark_data_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/get_polyline_use_case.dart';

class GeolocatorUseCases {

  FindPositionUseCase findPosition;
  CreateMarkerUseCase createMarker;
  GetMarkerUseCase getMarker;
  GetPlacemarkDataUseCase getPlacemarkData;
  GetPolylineUseCase getPolyline;
  // GetPositionStreamUseCase getPositionStream;

  GeolocatorUseCases({
    required this.findPosition,
    required this.createMarker,
    required this.getMarker,
    required this.getPlacemarkData,
    required this.getPolyline,
    // required this.getPositionStream,
  });

}