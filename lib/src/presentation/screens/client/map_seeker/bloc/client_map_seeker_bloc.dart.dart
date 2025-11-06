import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/geolocator_use_cases.dart';
import 'package:uber_clone/src/presentation/screens/client/map_seeker/bloc/client_map_seeker_event.dart.dart';
import 'package:uber_clone/src/presentation/screens/client/map_seeker/bloc/client_map_seeker_state.dart';

class ClientMapSeekerBloc extends Bloc<ClientMapSeekerEvent, ClientMapSeekerState> {
  
  GeolocatorUseCases geolocatorUseCases;
  final Completer<GoogleMapController> controller = Completer<GoogleMapController>();

  ClientMapSeekerBloc(this.geolocatorUseCases) : super(ClientMapSeekerState()) {
    on<ClientMapSeekerInitEvent>((event, emit) {
      emit(state.copyWith(controller: controller));
    });

    on<FindPosition>((event, emit) async {
      Position position = await geolocatorUseCases.findPosition.run();
      emit(state.copyWith(position: position, controller: controller));
      add(
        ChangeMapCameraPosition(
          lat: position.latitude,
          lng: position.longitude,
        ),
      );
      debugPrint('Position Lat: ${position.latitude}');
      debugPrint('Position Lng: ${position.longitude}');
    });

    on<ChangeMapCameraPosition>((event, emit) async {
      try {
        GoogleMapController googleMapController =
            await state.controller!.future;
        await googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(event.lat, event.lng),
              zoom: 13,
              bearing: 0,
            ),
          ),
        );
        debugPrint('SE POSICIONO LA CAMARA EN: ${event.lat}, ${event.lng}');
      } catch (e) {
        debugPrint('ERROR EN ChangeMapCameraPosition: $e');
      }
    });
  }
}
