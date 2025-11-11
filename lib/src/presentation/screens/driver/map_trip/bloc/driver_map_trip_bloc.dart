import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:uber_clone/bloc_socket_io/bloc_socket_io.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/client_requests_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/geolocator_use_cases.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_trip/bloc/driver_map_trip_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_trip/bloc/driver_map_trip_state.dart';

class DriverMapTripBloc extends Bloc<DriverMapTripEvent, DriverMapTripState> {
  BlocSocketIO blocSocketIO;
  StreamSubscription? positionSubscription;
  ClientRequestsUseCases clientRequestsUseCases;
  GeolocatorUseCases geolocatorUseCases;

  DriverMapTripBloc(
      this.blocSocketIO, this.clientRequestsUseCases, this.geolocatorUseCases)
      : super(DriverMapTripState()) {
    on<InitDriverMapTripEvent>((event, emit) async {
      Completer<GoogleMapController> controller =
          Completer<GoogleMapController>();
      emit(state.copyWith(
        controller: controller,
      ));
    });


    on<GetClientRequest>((event, emit) async {
      Resource response = await clientRequestsUseCases.getByClientRequest
          .run(event.idClientRequest);
      emit(state.copyWith(responseGetClientRequest: response));
    });

    on<ChangeMapCameraPosition>((event, emit) async {
      try {
        GoogleMapController googleMapController =
            await state.controller!.future;
        await googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(event.lat, event.lng), zoom: 14, bearing: 0)));
      } catch (e) {
        debugPrint('ChangeMapCameraPosition: $e');
      }
    });

    on<AddPolyline>((event, emit) async {
      if (state.position != null && state.clientRequestResponse != null) {
        List<LatLng> polylineCoordinates =
            await geolocatorUseCases.getPolyline.run(
          LatLng(event.originLat, event.originLng),
          LatLng(event.destinationLat, event.destinationLng),
        );
        PolylineId id = PolylineId(event.idPolyline);
        Polyline polyline = Polyline(
            polylineId: id,
            color: Colors.blueAccent,
            points: polylineCoordinates,
            width: 6);
        emit(state.copyWith(polylines: {id: polyline}));
      }
    });

    on<FindPosition>((event, emit) async {
      geolocator.Position position =
          await geolocatorUseCases.findPosition.run();
      add(ChangeMapCameraPosition(
          lat: position.latitude, lng: position.longitude));
      add(AddMyPositionMarker(lat: position.latitude, lng: position.longitude));
      Stream<geolocator.Position> positionStream =
          geolocatorUseCases.getPositionStream.run();
      positionSubscription = positionStream.listen((currentPosition) {
        // add(UpdateLocation(position: currentPosition as geolocator.Position));
      });
      emit(state.copyWith(
        position: position,
      ));
      add(AddPolyline(
        idPolyline: "pickup_polyline",
        originLat: state.position!.latitude,
        originLng: state.position!.longitude,
        destinationLat: state.clientRequestResponse!.pickupPosition.y,
        destinationLng: state.clientRequestResponse!.pickupPosition.x,
      ));
    });

    on<RemoveMarker>((event, emit) {
      emit(state.copyWith(
          markers: Map.of(state.markers)..remove(MarkerId(event.idMarker))));
    });

    on<UpdateLocation>((event, emit) async {
      add(AddMyPositionMarker(
          lat: event.position.latitude, lng: event.position.longitude));
      add(ChangeMapCameraPosition(
          lat: event.position.latitude, lng: event.position.longitude));
      emit(state.copyWith(position: event.position));
      add(EmitDriverPositionSocketIO());
    });

    on<StopLocation>((event, emit) {
      positionSubscription?.cancel();
    });

    on<EmitDriverPositionSocketIO>((event, emit) async {
      if (state.clientRequestResponse != null) {
        blocSocketIO.state.socket?.emit('trip_change_driver_position', {
          'id_client': state.clientRequestResponse!.idClient,
          'lat': state.position!.latitude,
          'lng': state.position!.longitude,
        });
      }
    });

    on<EmitUpdateStatusSocketIO>((event, emit) async {
      if (state.clientRequestResponse != null) {
        blocSocketIO.state.socket?.emit('update_status_trip', {
          'id_client_request': state.clientRequestResponse!.id,
          'status': state.statusTrip!.name,
        });
      }
    });



  }
}
