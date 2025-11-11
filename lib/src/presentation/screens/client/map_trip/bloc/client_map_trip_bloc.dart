import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/client_requests_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/geolocator_use_cases.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/client/map_trip/bloc/client_map_trip_event.dart';
import 'package:uber_clone/src/presentation/screens/client/map_trip/bloc/client_map_trip_state.dart';


class ClientMapTripBloc extends Bloc<ClientMapTripEvent, ClientMapTripState> {
  Timer? timer;
  BlocSocketIO blocSocketIO;
  ClientRequestsUseCases clientRequestsUseCases;
  GeolocatorUseCases geolocatorUseCases;
  AuthUseCases authUseCases;

  ClientMapTripBloc(this.blocSocketIO, this.clientRequestsUseCases,
      this.geolocatorUseCases, this.authUseCases)
      : super(ClientMapTripState()) {
    //
    //
    //
   on<InitClientMapTripEvent>((event, emit) async {
      Completer<GoogleMapController> controller =
          Completer<GoogleMapController>();
      emit(state.copyWith(
        controller: controller,
      ));
    });

    on<GetClientRequest>((event, emit) async {
      Resource response = await clientRequestsUseCases.getByClientRequest.run(event.idClientRequest);
      emit(state.copyWith(responseGetClientRequest: response));
    });


    on<GetTimeAndDistanceValues>((event, emit) async {
      // Resource response = await clientRequestsUseCases.getTimeAndDistance.run(
      //   event.driverLat,
      //   event.driverLng,
      //   state.clientRequestResponse!.pickupPosition.y,
      //   state.clientRequestResponse!.pickupPosition.x,
      // );
      // if (response is Success) {
      //   final data = response.data as TD.TimeAndDistanceValues;
      //   print('Time and Distance: ${data.toJson()}');
      //   emit(state.copyWith(timeAndDistanceValues: data));
      // }
    });

    on<AddMarkerPickup>((event, emit) async {
      BitmapDescriptor pickUpDescriptor = await geolocatorUseCases.createMarker
          .run('assets/img/person_location.png');
      Marker markerPickUp = geolocatorUseCases.getMarker.run(
          'pickup',
          event.lat,
          event.lng,
          'Lugar de recogida',
          'Debes permancer aqui mientras llega el conductor',
          pickUpDescriptor);
      emit(state.copyWith(
          markers: Map.of(state.markers)
            ..[markerPickUp.markerId] = markerPickUp));
    });

    on<AddMarkerDriver>((event, emit) async {
      MarkerId markerId = MarkerId('driver');
      LatLng newLatLng = LatLng(event.lat, event.lng);

      BitmapDescriptor descriptor = await geolocatorUseCases.createMarker
          .run('assets/img/car_yellow.png');

      if (state.markers.containsKey(markerId)) {
        LatLng previousPosition = state.markers[markerId]!.position;
        add(AnimateMarkerMovement(
            markerId: markerId, from: previousPosition, to: newLatLng));
      } else {
        Marker marker = Marker(
          markerId: markerId,
          position: newLatLng,
          rotation: 0,
          draggable: false,
          flat: true,
          icon: descriptor,
        );

        emit(state.copyWith(
          markers: Map.of(state.markers)..[markerId] = marker,
        ));
      }
    });

    on<AddMarkerDestination>((event, emit) async {
      BitmapDescriptor destinationDescriptor =
          await geolocatorUseCases.createMarker.run('assets/img/red_flag.png');
      Marker marker = geolocatorUseCases.getMarker.run('destination', event.lat,
          event.lng, 'Lugar de destino', '', destinationDescriptor);
      emit(state.copyWith(
          markers: Map.of(state.markers)..[marker.markerId] = marker));
    });


    on<AddPolyline>((event, emit) async {
      List<LatLng> polylineCoordinates = await geolocatorUseCases.getPolyline
          .run(LatLng(event.driverLat, event.driverLng),
              LatLng(event.destinationLat, event.destinationLng));
      PolylineId id = PolylineId("MyRoute");
      Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.blueAccent,
          points: polylineCoordinates,
          width: 6);
      emit(state.copyWith(polylines: {id: polyline}, isRouteDrawed: true));
    });


    on<ChangeMapCameraPosition>((event, emit) async {
      try {
        GoogleMapController googleMapController =
            await state.controller!.future;
        await googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(event.lat, event.lng), zoom: 12, bearing: 0)));
      } catch (e) {
        debugPrint('Error ChangeMapCameraPosition: $e');
      }
    });

  }
}

