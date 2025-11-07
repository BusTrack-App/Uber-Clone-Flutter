import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/geolocator_use_cases.dart';
import 'driver_map_location_event.dart';
import 'driver_map_location_state.dart';

class DriverMapLocationBloc
    extends Bloc<DriverMapLocationEvent, DriverMapLocationState> {
  final GeolocatorUseCases geolocatorUseCases;
  StreamSubscription? positionSubscription;

  DriverMapLocationBloc(this.geolocatorUseCases)
    : super(DriverMapLocationState()) {
    on<DriverMapLocationInitEvent>((event, emit) {
      emit(state.copyWith(controller: Completer<GoogleMapController>()));
    });

    on<FindPosition>((event, emit) async {
      Position position = await geolocatorUseCases.findPosition.run();
      add(
        ChangeMapCameraPosition(
          lat: position.latitude,
          lng: position.longitude,
        ),
      );
      add(AddMyPositionMarker(lat: position.latitude, lng: position.longitude));
      Stream<Position> positionStream = geolocatorUseCases.getPositionStream
          .run();
      positionSubscription = positionStream.listen((Position position) {
        add(UpdateLocation(position: position));
      });
      emit(state.copyWith(position: position));
    });

    on<AddMyPositionMarker>((event, emit) async {
      BitmapDescriptor descriptor = await geolocatorUseCases.createMarker.run('assets/img/pin_white.png');
      Marker marker = geolocatorUseCases.getMarker.run(
        'my_location',
        event.lat,
        event.lng,
        'Mi posicion',
        '',
        descriptor
      );
      emit(
        state.copyWith(
          markers: {
            marker.markerId: marker
          },
        )
      );
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

    on<UpdateLocation>((event, emit) async {
      debugPrint('New Position ${event.position}');
      add(AddMyPositionMarker(lat: event.position.latitude, lng: event.position.longitude));
      add(ChangeMapCameraPosition(lat: event.position.latitude, lng: event.position.longitude));
      emit(state.copyWith(position: event.position));
    });

    on<StopLocation>((event, emit) {
      positionSubscription?.cancel();
    });
  }
}
