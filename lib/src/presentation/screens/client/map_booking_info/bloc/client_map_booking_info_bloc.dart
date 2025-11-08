import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/src/domain/models/auth_response.dart';
import 'package:uber_clone/src/domain/models/client_request.dart';
import 'package:uber_clone/src/domain/models/time_and_distance_values.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/client_requests_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/geolocator_use_cases.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/client/map_booking_info/bloc/client_map_booking_info_event.dart';
import 'package:uber_clone/src/presentation/screens/client/map_booking_info/bloc/client_map_booking_info_state.dart';
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';

class ClientMapBookingInfoBloc
    extends Bloc<ClientMapBookingInfoEvent, ClientMapBookingInfoState> {
  GeolocatorUseCases geolocatorUseCases;
  ClientRequestsUseCases clientRequestsUseCases;
  AuthUseCases authUseCases;
  // BlocSocketIO blocSocketIO;

  // ClientMapBookingInfoBloc(this.blocSocketIO, this.geolocatorUseCases, this.clientRequestsUseCases, this.authUseCases): super(ClientMapBookingInfoState()) {
  ClientMapBookingInfoBloc(this.geolocatorUseCases, this.clientRequestsUseCases, this.authUseCases)
    : super(ClientMapBookingInfoState()) {
    // ----------- INIT EVENT ----------------
    on<ClientMapBookingInfoInitEvent>((event, emit) async {
      Completer<GoogleMapController> controller =
          Completer<GoogleMapController>();
      emit(
        state.copyWith(
          pickUpLatLng: event.pickUpLatLng,
          destinationLatLng: event.destinationLatLng,
          pickUpDescription: event.pickUpDescription,
          destinationDescription: event.destinationDescription,
          controller: controller,
        ),
      );
      BitmapDescriptor pickUpDescriptor = await geolocatorUseCases.createMarker
          .run('assets/img/pin_white.png');
      BitmapDescriptor destinationDescriptor = await geolocatorUseCases
          .createMarker
          .run('assets/img/flag.png');
      Marker markerPickUp = geolocatorUseCases.getMarker.run(
        'pickup',
        state.pickUpLatLng!.latitude,
        state.pickUpLatLng!.longitude,
        'Lugar de recogida',
        'Debes permancer aqui mientras llega el conductor',
        pickUpDescriptor,
      );
      Marker markerDestination = geolocatorUseCases.getMarker.run(
        'destination',
        state.destinationLatLng!.latitude,
        state.destinationLatLng!.longitude,
        'Tu Destino',
        '',
        destinationDescriptor,
      );
      emit(
        state.copyWith(
          markers: {
            markerPickUp.markerId: markerPickUp,
            markerDestination.markerId: markerDestination,
          },
        ),
      );
    });

    on<FareOfferedChanged>((event, emit) {
      emit(
        state.copyWith(fareOffered: BlocFormItem(
          value: event.fareOffered.value,
          error: event.fareOffered.value.isEmpty ? 'Ingresa la tarifa' : null
        ))
      );
    });

    on<CreateClientRequest>((event, emit) async {
      AuthResponse authResponse = await authUseCases.getUserSession.run();

      Resource<int> response = await clientRequestsUseCases.createClientRequest.run(
        ClientRequest(
          idClient: authResponse.user.id!, 
          fareOffered: double.parse(state.fareOffered.value), 
          pickupDescription: state.pickUpDescription, 
          destinationDescription: state.destinationDescription, 
          pickupLat: state.pickUpLatLng!.latitude, 
          pickupLng: state.pickUpLatLng!.longitude, 
          destinationLat: state.destinationLatLng!.latitude, 
          destinationLng: state.destinationLatLng!.longitude
        )
      );

      emit(
        state.copyWith(
          responseClientRequest: response
        )
      );
    });

    on<GetTimeAndDistanceValues>((event, emit) async {
      emit(
        state.copyWith(
          responseTimeAndDistance: Loading()
        )
      );
      Resource<TimeAndDistanceValues> response = await clientRequestsUseCases.getTimeAndDistance.run(
        state.pickUpLatLng!.latitude,
        state.pickUpLatLng!.longitude,
        state.destinationLatLng!.latitude,
        state.destinationLatLng!.longitude,
      );
      emit(
        state.copyWith(
          responseTimeAndDistance: response
        )
      );
    });

    on<ChangeMapCameraPosition>((event, emit) async {
      GoogleMapController googleMapController = await state.controller!.future;
      await googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(event.lat, event.lng),
            zoom: 12,
            bearing: 0,
          ),
        ),
      );
    });

    on<AddPolyline>((event, emit) async {
      List<LatLng> polylineCoordinates = await geolocatorUseCases.getPolyline
          .run(state.pickUpLatLng!, state.destinationLatLng!);
      PolylineId id = PolylineId("MyRoute");
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.blueAccent,
        points: polylineCoordinates,
        width: 6,
      );
      emit(state.copyWith(polylines: {id: polyline}));
    });
  }
}
