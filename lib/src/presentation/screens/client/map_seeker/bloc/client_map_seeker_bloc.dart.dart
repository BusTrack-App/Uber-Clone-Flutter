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
      // add(
      //   ChangeMapCameraPosition(
      //     lat: position.latitude,
      //     lng: position.longitude,
      //   ),
      // );
      emit(state.copyWith(position: position, controller: controller));
      debugPrint('Position Lat: ${position.latitude}');
      debugPrint('Position Lng: ${position.longitude}');
    });

    // on<ChangeMapCameraPosition>((event, emit) async {
    //   try {
    //     GoogleMapController googleMapController =
    //         await state.controller!.future;
    //     await googleMapController.animateCamera(CameraUpdate.newCameraPosition(
    //         CameraPosition(
    //             target: LatLng(event.lat, event.lng), zoom: 13, bearing: 0)));
    //   } catch (e) {
    //     debugPrint('ERROR EN ChangeMapCameraPosition: $e');
    //   }
    // });

    // on<OnCameraMove>((event, emit) {
    //   emit(state.copyWith(cameraPosition: event.cameraPosition));
    // });

    // on<OnCameraIdle>((event, emit) async {
    //   try {
    //     PlacemarkData placemarkData =
    //         await geolocatorUseCases.getPlacemarkData.run(state.cameraPosition);
    //     emit(state.copyWith(placemarkData: placemarkData));
    //   } catch (e) {
    //     debugPrint('OnCameraIdle Error: $e');
    //   }
    // });

    // on<OnAutoCompletedPickUpSelected>((event, emit) {
    //   emit(state.copyWith(
    //       pickUpLatLng: LatLng(event.lat, event.lng),
    //       pickUpDescription: event.pickUpDescription));
    // });

    // on<OnAutoCompletedDestinationSelected>((event, emit) {
    //   emit(state.copyWith(
    //       destinationLatLng: LatLng(event.lat, event.lng),
    //       destinationDescription: event.destinationDescription));
    // });

    // on<ListenDriversPositionSocketIO>((event, emit) async {
    //   if (blocSocketIO.state.socket != null) {
    //     blocSocketIO.state.socket?.on('new_driver_position', (data) {
    //       debugPrint('SOCKET DATA: ${data}');
    //       add(AddDriverPositionMarker(
    //           idSocket: data['id_socket'] as String,
    //           id: data['id'] as int,
    //           lat: data['lat'] as double,
    //           lng: data['lng'] as double));
    //     });
    //   }
    //   else {
    //     debugPrint('SOCKET ES NULO');
    //   }
    // });

    // on<ListenDriversDisconnectedSocketIO>((event, emit) {
    //   if (blocSocketIO.state.socket != null) {
    //     blocSocketIO.state.socket?.on('driver_disconnected', (data) {
    //       debugPrint('Id: ${data['id_socket']}');
    //       add(RemoveDriverPositionMarker(
    //           idSocket: data['id_socket'] as String));
    //     });
    //   }
    // });

    // on<RemoveDriverPositionMarker>((event, emit) {
    //   emit(state.copyWith(
    //       markers: Map.of(state.markers)..remove(MarkerId(event.idSocket))));
    // });

    // on<AddDriverPositionMarker>((event, emit) async {
    //   MarkerId markerId = MarkerId(event.idSocket);
    //   LatLng newLatLng = LatLng(event.lat, event.lng);

    //   BitmapDescriptor descriptor = await geolocatorUseCases.createMarker
    //       .run('assets/img/car_yellow.png');

    //   if (state.markers.containsKey(markerId)) {
    //     LatLng previusPosition = state.markers[markerId]!.position;
    //     add(AnimateMarkerMovement(
    //         markerId: markerId, from: previusPosition, to: newLatLng));
    //   } else {
    //     Marker marker = Marker(
    //         markerId: markerId,
    //         position: newLatLng,
    //         rotation: 0,
    //         draggable: false,
    //         flat: true,
    //         icon: descriptor);
    //     emit(state.copyWith(
    //         markers: Map.of(state.markers)..[markerId] = marker));
    //   }
    // });

    // on<AnimateMarkerMovement>((event, emit) async {
    //   const int animationDuration = 1000;
    //   const int frameRate = 60;
    //   int frameCount = (animationDuration / (1000 / frameRate)).round();

    //   for (int i = 1; i <= frameCount; i++) {
    //     double lat = event.from.latitude +
    //         (event.to.latitude - event.from.latitude) * (i / frameCount);
    //     double lng = event.from.longitude +
    //         (event.to.longitude - event.from.longitude) * (i / frameCount);
    //     LatLng newPosition = LatLng(lat, lng);

    //     double rotation = calculateRotation(event.from, event.to);
    //     Marker? existingMarker = state.markers[event.markerId];
    //     if (existingMarker != null) {
    //       Marker updatedMarker = existingMarker.copyWith(
    //           positionParam: newPosition, rotationParam: rotation);

    //       emit(state.copyWith(
    //           markers: Map.of(state.markers)
    //             ..[event.markerId] = updatedMarker));
    //     }
    //     await Future.delayed(
    //         Duration(milliseconds: (1000 / frameRate).round()));
    //   }
    // });
  }
}
