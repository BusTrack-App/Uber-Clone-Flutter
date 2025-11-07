// driver_map_location_bloc.dart
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/geolocator_use_cases.dart';
import 'driver_map_location_event.dart';
import 'driver_map_location_state.dart';

class DriverMapLocationBloc extends Bloc<DriverMapLocationEvent, DriverMapLocationState> {
  final GeolocatorUseCases geolocatorUseCases;

  DriverMapLocationBloc(this.geolocatorUseCases) : super(DriverMapLocationState()) {
    on<DriverMapLocationInitEvent>((event, emit) {
      emit(state.copyWith(
        controller: Completer<GoogleMapController>(),
      ));
    });

    on<FindPosition>((event, emit) async {
      try {
        // 1. Obtener posición
        Position position = await geolocatorUseCases.findPosition.run();

        // 2. Crear ícono personalizado
        BitmapDescriptor icon = await geolocatorUseCases.createMarker.run('assets/img/car_pin.png');

        // 3. Crear marcador
        Marker marker = Marker(
          markerId: const MarkerId('my_location'),
          position: LatLng(position.latitude, position.longitude),
          icon: icon,
          infoWindow: const InfoWindow(title: 'Mi ubicación'),
        );

        // 4. Mover cámara
        add(ChangeMapCameraPosition(lat: position.latitude, lng: position.longitude));

        // 5. Emitir estado con marcador
        emit(state.copyWith(
          position: position,
          markers: {marker.markerId: marker},
        ));
      } catch (e) {
        debugPrint('ERROR: $e');
      }
    });

    on<ChangeMapCameraPosition>((event, emit) async {
      try {
        final controller = await state.controller!.future;
        await controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(event.lat, event.lng), zoom: 15),
          ),
        );
      } catch (e) {
        debugPrint('Error cámara: $e');
      }
    });
  }
}