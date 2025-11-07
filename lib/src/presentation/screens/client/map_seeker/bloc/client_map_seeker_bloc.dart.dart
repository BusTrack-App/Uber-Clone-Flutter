import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uber_clone/src/domain/models/placemark_data.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/geolocator_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/socket/socket_use_cases.dart';
import 'package:uber_clone/src/presentation/screens/client/map_seeker/bloc/client_map_seeker_event.dart.dart';
import 'package:uber_clone/src/presentation/screens/client/map_seeker/bloc/client_map_seeker_state.dart';

class ClientMapSeekerBloc
    extends Bloc<ClientMapSeekerEvent, ClientMapSeekerState> {
  GeolocatorUseCases geolocatorUseCases;
  SocketUseCases socketUseCases;

  ClientMapSeekerBloc(this.geolocatorUseCases, this.socketUseCases)
    : super(ClientMapSeekerState()) {
    on<ClientMapSeekerInitEvent>((event, emit) {
      final Completer<GoogleMapController> controller =
          Completer<GoogleMapController>();
      emit(state.copyWith(controller: controller));
    });

    on<FindPosition>((event, emit) async {
      Position position = await geolocatorUseCases.findPosition.run();

      // BitmapDescriptor imageMarker = await geolocatorUseCases.createMarker.run(
      //   'assets/img/location_blue.png',
      // );
      // Marker marker = geolocatorUseCases.getMarker.run(
      //   'MyLocation',
      //   position.latitude,
      //   position.longitude,
      //   'Mi Posicion',
      //   '',
      //   imageMarker,
      // );
      add(
        ChangeMapCameraPosition(
          lat: position.latitude,
          lng: position.longitude,
        ),
      );
      emit(
        state.copyWith(
          position: position,
          // markers: {
          //   marker.mapsId: marker
          // },
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

    on<OnCameraMove>((event, emit) {
      emit(state.copyWith(cameraPosition: event.cameraPosition));
    });

    on<OnCameraIdle>((event, emit) async {
      try {
        PlacemarkData placemarkData = await geolocatorUseCases.getPlacemarkData
            .run(state.cameraPosition);
        emit(state.copyWith(placemarkData: placemarkData));
      } catch (e) {
        debugPrint('OnCameraIdle Error: $e');
      }
    });

    on<OnAutoCompletedPickUpSelected>((event, emit) {
      emit(
        state.copyWith(
          pickUpLatLng: LatLng(event.lat, event.lng),
          pickUpDescription: event.pickUpDescription,
        ),
      );
    });

    on<OnAutoCompletedDestinationSelected>((event, emit) {
      emit(
        state.copyWith(
          destinationLatLng: LatLng(event.lat, event.lng),
          destinationDescription: event.destinationDescription,
        ),
      );
    });

    on<ConnectSocketIo>((event, emit) {
      Socket socket = socketUseCases.connect.run();
      debugPrint('Conectado al socket');
      emit(state.copyWith(socket: socket));
      add(ListenDriversDisconnectedSocketIO());
    });

    on<DisconnectSocketIo>((event, emit) {
      debugPrint('Desconectado al socket');
      Socket socket = socketUseCases.disconnect.run();
      emit(state.copyWith(socket: socket));
    });

    on<ListenDriversPositionSocketIO>((event, emit) async {
      debugPrint('Dentro del Listener Driver');
      state.socket?.on('new_driver_position', (data) {
        debugPrint('SOCKET DATA:');
        debugPrint('SOCKET DATA: ${data['id']}');
        debugPrint('SOCKET DATA: ${data['lat']}');
        debugPrint('SOCKET DATA: ${data['lng']}');
      });

      // if (blocSocketIO.state.socket != null) {
      //   blocSocketIO.state.socket?.on('new_driver_position', (data) {
      //     add(AddDriverPositionMarker(
      //         idSocket: data['id_socket'] as String,
      //         id: data['id'] as int,
      //         lat: data['lat'] as double,
      //         lng: data['lng'] as double));
      //   });
      // }
      // else {
      //   print('SOCKET ES NULO');
      // }
    });
  }
}
