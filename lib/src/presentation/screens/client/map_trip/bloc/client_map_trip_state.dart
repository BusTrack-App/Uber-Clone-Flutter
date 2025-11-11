import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/domain/models/time_and_distance_values.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

class ClientMapTripState extends Equatable {

  final Resource? responseGetClientRequest;
  final Completer<GoogleMapController>? controller;
  final CameraPosition cameraPosition;
  final Map<MarkerId, Marker> markers;
  final Map<PolylineId, Polyline> polylines;
  final TimeAndDistanceValues? timeAndDistanceValues;
  final ClientRequestResponse? clientRequestResponse;
  final bool isRouteDrawed;
  final LatLng? driverLatLng;

  const ClientMapTripState({
    this.responseGetClientRequest,
    this.controller,
    this.cameraPosition = const CameraPosition(target: LatLng(4.7449125, -74.1113708), zoom: 14.0),
    this.markers = const <MarkerId, Marker>{},
    this.polylines = const <PolylineId, Polyline>{},
    this.timeAndDistanceValues,
    this.clientRequestResponse,
    this.isRouteDrawed = false,
    this.driverLatLng
  });

  ClientMapTripState copyWith({
    Resource? responseGetClientRequest,
    Completer<GoogleMapController>? controller,
    CameraPosition? cameraPosition,
    Map<MarkerId, Marker>? markers,
    Map<PolylineId, Polyline>? polylines,
    ClientRequestResponse? clientRequestResponse,
    bool? isRouteDrawed,
    TimeAndDistanceValues? timeAndDistanceValues,
    LatLng? driverLatLng
  }) {
    return ClientMapTripState(
      responseGetClientRequest: responseGetClientRequest ?? this.responseGetClientRequest,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      controller: controller ?? this.controller,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      timeAndDistanceValues: timeAndDistanceValues ?? this.timeAndDistanceValues,
      clientRequestResponse: clientRequestResponse ?? this.clientRequestResponse,
      isRouteDrawed: isRouteDrawed ?? this.isRouteDrawed,
      driverLatLng: driverLatLng ?? this.driverLatLng
    );
  }

  @override
  List<Object?> get props => [responseGetClientRequest, timeAndDistanceValues, controller, markers, polylines, cameraPosition, clientRequestResponse, isRouteDrawed, driverLatLng];

}