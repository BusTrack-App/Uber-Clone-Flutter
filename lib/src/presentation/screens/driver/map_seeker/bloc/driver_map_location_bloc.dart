import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/geolocator_use_cases.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_seeker/bloc/driver_map_location_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_seeker/bloc/driver_map_location_state.dart';

class DriverMapLocationBloc extends Bloc<DriverMapLocationEvent, DriverMapLocationState> {

  GeolocatorUseCases geolocatorUseCases;


  DriverMapLocationBloc(this.geolocatorUseCases) : super(DriverMapLocationState()) {
    on<DriverMapLocationInitEvent>((event, emit) {
      final Completer<GoogleMapController> controller = Completer<GoogleMapController>();
      emit(state.copyWith(controller: controller));
    });

    on<FindPosition>((event, emit) async {
      Position position = await geolocatorUseCases.findPosition.run();
      add(ChangeMapCameraPosition(lat: position.latitude, lng: position.longitude));
      add(AddMyPositionMarker(lat: position.latitude, lng: position.longitude));
      // Stream<Position> positionStream = geolocatorUseCases.getPositionStream.run();
      // positionSubscription = positionStream.listen((Position position) {
      //   add(UpdateLocation(position: position));
      //   add(SaveLocationData(
      //     driverPosition: DriverPosition(
      //       idDriver: state.idDriver!, 
      //       lat: position.latitude, 
      //       lng: position.longitude)
      //     )
      //   );
      // });
      emit(
        state.copyWith(
          position: position,
        )
      );
    });

    on<ChangeMapCameraPosition>((event, emit) async {
      try {
        GoogleMapController googleMapController = await state.controller!.future;
        await googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(event.lat, event.lng),
            zoom: 13,
            bearing: 0
          )
        ));
      } catch (e) {
        debugPrint('ERROR EN ChangeMapCameraPosition: $e');
      }
      
    }); 

    on<OnCameraMove>((event, emit) {
      emit(state.copyWith(cameraPosition: event.cameraPosition));
    });



  }
}
