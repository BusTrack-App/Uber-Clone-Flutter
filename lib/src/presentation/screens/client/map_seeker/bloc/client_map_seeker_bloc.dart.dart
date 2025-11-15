import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io.dart';
import 'package:uber_clone/src/domain/models/placemark_data.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/geolocator_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/socket/socket_use_cases.dart';
import 'package:uber_clone/src/presentation/screens/client/map_seeker/bloc/client_map_seeker_event.dart.dart';
import 'package:uber_clone/src/presentation/screens/client/map_seeker/bloc/client_map_seeker_state.dart';

class ClientMapSeekerBloc
    extends Bloc<ClientMapSeekerEvent, ClientMapSeekerState> {
  GeolocatorUseCases geolocatorUseCases;
  SocketUseCases socketUseCases;
  BlocSocketIO blocSocketIO;

  ClientMapSeekerBloc(
    this.blocSocketIO,
    this.geolocatorUseCases,
    this.socketUseCases,
  ) : super(ClientMapSeekerState()) {
    on<ClientMapSeekerInitEvent>((event, emit) {
      final Completer<GoogleMapController> controller =
          Completer<GoogleMapController>();
      emit(state.copyWith(controller: controller));
    });

    on<FindPosition>((event, emit) async {
      Position position = await geolocatorUseCases.findPosition.run();

      add(
        ChangeMapCameraPosition(
          lat: position.latitude,
          lng: position.longitude,
        ),
      );
      emit(
        state.copyWith(
          position: position,
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
        // Ahora getPlacemarkData SIEMPRE retorna un PlacemarkData válido
        PlacemarkData placemarkData = await geolocatorUseCases.getPlacemarkData
            .run(state.cameraPosition);
        
        // VALIDAR que la dirección no esté vacía o solo tenga comas
        if (placemarkData.address.trim().isEmpty || 
            placemarkData.address.replaceAll(RegExp(r'[,\s]'), '').isEmpty) {
          debugPrint('OnCameraIdle: Dirección inválida obtenida - ${placemarkData.address}');
          // No emitir un placemarkData inválido
          return;
        }
        
        emit(state.copyWith(placemarkData: placemarkData));
      } catch (e) {
        debugPrint('OnCameraIdle Error: $e');
        // No emitir nada si hay error, mantener el estado actual
      }
    });

    on<OnAutoCompletedPickUpSelected>((event, emit) {
      // VALIDACIÓN: No permitir descripciones vacías o solo con comas
      String cleanDescription = _cleanAddress(event.pickUpDescription);
      
      if (cleanDescription.isEmpty) {
        debugPrint('PickUp: Descripción inválida - ${event.pickUpDescription}');
        return;
      }
      
      emit(
        state.copyWith(
          pickUpLatLng: LatLng(event.lat, event.lng),
          pickUpDescription: cleanDescription,
        ),
      );
    });

    on<OnAutoCompletedDestinationSelected>((event, emit) {
      // VALIDACIÓN: No permitir descripciones vacías o solo con comas
      String cleanDescription = _cleanAddress(event.destinationDescription);
      
      if (cleanDescription.isEmpty) {
        debugPrint('Destination: Descripción inválida - ${event.destinationDescription}');
        return;
      }
      
      emit(
        state.copyWith(
          destinationLatLng: LatLng(event.lat, event.lng),
          destinationDescription: cleanDescription,
        ),
      );
    });

    on<ListenDriversPositionSocketIO>((event, emit) async {
      if (blocSocketIO.state.socket != null) {
        blocSocketIO.state.socket?.on('new_driver_position', (data) {
          debugPrint('SOCKET DATA: $data');
          add(AddDriverPositionMarker(
              idSocket: data['id_socket'] as String,
              id: data['id'] as int,
              lat: data['lat'] as double,
              lng: data['lng'] as double));
        });
      }
      else {
        debugPrint('SOCKET ES NULO');
      }
    });

    on<ListenDriversDisconnectedSocketIO>((event, emit) {
      if (blocSocketIO.state.socket != null) {
        blocSocketIO.state.socket?.on('driver_disconnected', (data) {
          debugPrint('Id: ${data['id_socket']}');
          add(RemoveDriverPositionMarker(
              idSocket: data['id_socket'] as String));
        });
      }
    });

    on<RemoveDriverPositionMarker>((event, emit) {
      emit(
        state.copyWith(
          markers: Map.of(state.markers)..remove(MarkerId(event.idSocket)),
        ),
      );
    });

    on<AddDriverPositionMarker>((event, emit) async {
      MarkerId markerId = MarkerId(event.idSocket);
      LatLng newLatLng = LatLng(event.lat, event.lng);

      BitmapDescriptor descriptor = await geolocatorUseCases.createMarker.run(
        'assets/img/car_yellow.png',
      );

      Marker marker = Marker(
        markerId: markerId,
        position: newLatLng,
        rotation: 0,
        draggable: false,
        flat: true,
        icon: descriptor,
      );
      emit(state.copyWith(markers: Map.of(state.markers)..[markerId] = marker));
    });
  }
  
  // FUNCIÓN HELPER para limpiar direcciones
  String _cleanAddress(String address) {
    // Eliminar comas al inicio y final
    String cleaned = address.trim();
    
    // Eliminar comas duplicadas y espacios extras
    cleaned = cleaned
        .replaceAll(RegExp(r',\s*,+'), ', ')  // Reemplazar ", ," por ", "
        .replaceAll(RegExp(r'^\s*,+\s*'), '')  // Eliminar comas al inicio
        .replaceAll(RegExp(r'\s*,+\s*$'), ''); // Eliminar comas al final
    
    // Si después de limpiar solo quedan espacios o comas, retornar vacío
    if (cleaned.replaceAll(RegExp(r'[,\s]'), '').isEmpty) {
      return '';
    }
    
    return cleaned;
  }
}