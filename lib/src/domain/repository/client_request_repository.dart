

import 'package:uber_clone/src/domain/models/client_request.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/domain/models/status_trip.dart';
import 'package:uber_clone/src/domain/models/time_and_distance_values.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

abstract class ClientRequestsRepository {

  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequets(
    double originLat,
    double originLng,
    double destinationLat,
    double destinationLng,
  );

  Future<Resource<int>> create(ClientRequest clientRequest);

  // Actualizacion de estatus
  Future<Resource<bool>> updateDriverAssigned(int idClientRequest, int idDriver, double fareAssigned);

  Future<Resource<bool>> updateStatus(int idClientRequest, StatusTrip statusTrip);

  // Rating trip
  Future<Resource<bool>> updateDriverRating(int idClientRequest, double rating);
  Future<Resource<bool>> updateClientRating(int idClientRequest, double rating);


  Future<Resource<List<ClientRequestResponse>>> getNearbyTripRequest(double driverLat,double driverLng);

  Future<Resource<ClientRequestResponse>> getByClientRequest(int idClientRequest);

  // Obtener Historial
  Future<Resource<List<ClientRequestResponse>>> getByDriverAssigned(int idDriver);
  Future<Resource<List<ClientRequestResponse>>> getByClientAssigned(int idClient);

}