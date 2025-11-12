import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

double calculateRotation(LatLng from, LatLng to) {
  double deltaLng = to.longitude - from.longitude;
  double deltaLat = to.latitude - from.latitude;

  double angle = atan2(deltaLng, deltaLat) * (180 / pi);
  return (angle + 360) % 360; // rotacion positiva entre 0 y 360
}

double distanceBetween(LatLng from, LatLng to) {
  return Geolocator.distanceBetween(
      from.latitude, from.longitude, to.latitude, to.longitude);
}
