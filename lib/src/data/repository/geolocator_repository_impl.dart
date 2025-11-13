import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/src/data/api/ApiKeyGoogle.dart';
import 'package:uber_clone/src/domain/models/placemark_data.dart';
import 'package:uber_clone/src/domain/repository/geolocator_repository.dart';

class GeolocatorRepositoryImpl implements GeolocatorRepository {
  @override
  Future<Position> findPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('La ubicacion no esta activada');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Permiso no otorgado por el usuario');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint('Permiso no otorgado por el usuario permanentemente');
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<BitmapDescriptor> createMarkerFromAsset(String path) async {
    ImageConfiguration configuration = const ImageConfiguration();
    BitmapDescriptor descriptor = await BitmapDescriptor.asset(
      configuration,
      path,
    );
    return descriptor;
  }

  @override
  Marker getMarker(
    String markerId,
    double lat,
    double lng,
    String title,
    String content,
    BitmapDescriptor imageMarker,
  ) {
    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
      markerId: id,
      icon: imageMarker,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: title, snippet: content),
    );
    return marker;
  }

  @override
  Future<PlacemarkData> getPlacemarkData(CameraPosition cameraPosition) async {
    try {
      double lat = cameraPosition.target.latitude;
      double lng = cameraPosition.target.longitude;
      
      debugPrint('🔍 Obteniendo placemark para: $lat, $lng');
      
      List<Placemark> placemarkList = await placemarkFromCoordinates(
        lat, 
        lng
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          debugPrint('⏱️ Timeout obteniendo placemark');
          return [];
        },
      );

      if (placemarkList.isEmpty) {
        debugPrint('⚠️ No se encontraron placemarks, usando coordenadas');
        return PlacemarkData(
          address: 'Lat: ${lat.toStringAsFixed(6)}, Lng: ${lng.toStringAsFixed(6)}',
          lat: lat,
          lng: lng,
        );
      }

      Placemark placemark = placemarkList[0];
      
      // SOLUCIÓN: Construir dirección de forma segura manejando nulls
      String address = _buildAddressSafely(placemark);
      
      debugPrint('✅ Dirección obtenida: $address');
      
      // Si después de construir la dirección está vacía, usar coordenadas
      if (address.trim().isEmpty || address.replaceAll(RegExp(r'[,\s]'), '').isEmpty) {
        debugPrint('⚠️ Dirección vacía, usando coordenadas');
        address = 'Lat: ${lat.toStringAsFixed(6)}, Lng: ${lng.toStringAsFixed(6)}';
      }

      return PlacemarkData(
        address: address,
        lat: lat,
        lng: lng,
      );
      
    } catch (e) {
      debugPrint('❌ Error en getPlacemarkData: $e');
      
      // En lugar de retornar null, retornar PlacemarkData con coordenadas
      return PlacemarkData(
        address: 'Lat: ${cameraPosition.target.latitude.toStringAsFixed(6)}, Lng: ${cameraPosition.target.longitude.toStringAsFixed(6)}',
        lat: cameraPosition.target.latitude,
        lng: cameraPosition.target.longitude,
      );
    }
  }

  // Método helper para construir dirección de forma segura
  String _buildAddressSafely(Placemark placemark) {
    List<String> parts = [];

    // El orden típico en Colombia es: Calle/Carrera, Número, Barrio, Ciudad, Departamento
    
    // 1. Calle principal (thoroughfare)
    if (placemark.thoroughfare != null && placemark.thoroughfare!.isNotEmpty) {
      parts.add(placemark.thoroughfare!);
    }

    // 2. Número de calle (subThoroughfare)
    if (placemark.subThoroughfare != null && placemark.subThoroughfare!.isNotEmpty) {
      if (parts.isNotEmpty) {
        // Concatenar con la calle si existe
        parts[parts.length - 1] = '${parts.last} ${placemark.subThoroughfare}';
      } else {
        parts.add(placemark.subThoroughfare!);
      }
    }

    // 3. Barrio o sub-localidad (subLocality)
    if (placemark.subLocality != null && placemark.subLocality!.isNotEmpty) {
      parts.add(placemark.subLocality!);
    }

    // 4. Ciudad (locality)
    if (placemark.locality != null && placemark.locality!.isNotEmpty) {
      parts.add(placemark.locality!);
    }

    // 5. Departamento/Estado (administrativeArea)
    if (placemark.administrativeArea != null && placemark.administrativeArea!.isNotEmpty) {
      parts.add(placemark.administrativeArea!);
    }

    // 6. País (country) - opcional, solo si es necesario
    // if (placemark.country != null && placemark.country!.isNotEmpty) {
    //   parts.add(placemark.country!);
    // }

    // Unir todas las partes con comas
    String address = parts.join(', ');

    debugPrint('📍 Componentes de dirección:');
    debugPrint('  - Thoroughfare: ${placemark.thoroughfare}');
    debugPrint('  - SubThoroughfare: ${placemark.subThoroughfare}');
    debugPrint('  - SubLocality: ${placemark.subLocality}');
    debugPrint('  - Locality: ${placemark.locality}');
    debugPrint('  - AdministrativeArea: ${placemark.administrativeArea}');
    debugPrint('  - Dirección final: $address');

    return address;
  }

  @override
  Future<List<LatLng>> getPolyline(LatLng pickUpLatLng, LatLng destinationLatLng) async {
    try {
      PolylineResult result = await PolylinePoints(apiKey: API_KEY_GOOGLE).getRouteBetweenCoordinates(
        request: PolylineRequest(
          origin: PointLatLng(pickUpLatLng.latitude, pickUpLatLng.longitude),
          destination: PointLatLng(destinationLatLng.latitude, destinationLatLng.longitude),
          mode: TravelMode.driving,
          wayPoints: [PolylineWayPoint(location: "Bogota, Colombia")],
        ),
      );
      
      List<LatLng> polylineCoordinates = [];
      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      }
      return polylineCoordinates;
    } catch (e) {
      debugPrint('Error getting polyline: $e');
      return [];
    }
  }
  
  @override
  Stream<Position> getPositionStream() {
    LocationSettings locationSettings =
        LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 1);
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }
}