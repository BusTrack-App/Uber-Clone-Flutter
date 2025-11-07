import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverMapLocationState extends Equatable {
  final Completer<GoogleMapController>? controller;
  final Position? position;
  final CameraPosition cameraPosition;
  final Map<MarkerId, Marker> markers;

  const DriverMapLocationState({
    this.position,
    this.controller,
    this.cameraPosition = const CameraPosition(
      target: LatLng(4.7449125, -74.1113708),
      zoom: 14.0,
    ),
    this.markers = const <MarkerId, Marker>{},
  });

  DriverMapLocationState copyWith({
    Position? position,
    StreamSubscription? positionSubscription,
    Completer<GoogleMapController>? controller,
    CameraPosition? cameraPosition,
    Map<MarkerId, Marker>? markers,
  }) {
    return DriverMapLocationState(
      position: position ?? this.position,
      markers: markers ?? this.markers,
      controller: controller ?? this.controller,
      cameraPosition: cameraPosition ?? this.cameraPosition,
    );
  }

  @override
  List<Object?> get props => [position, markers, controller, cameraPosition];
}
