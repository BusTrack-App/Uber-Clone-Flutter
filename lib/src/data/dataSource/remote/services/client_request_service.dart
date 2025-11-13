import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uber_clone/src/data/api/api_config.dart';
import 'package:uber_clone/src/domain/models/client_request.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/domain/models/status_trip.dart';
import 'package:uber_clone/src/domain/models/time_and_distance_values.dart';
import 'package:uber_clone/src/domain/utils/list_to_string.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

class ClientRequestsService {
  Future<String> token;
  ClientRequestsService(this.token);

  Future<Resource<int>> create(ClientRequest clientRequest) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/client-requests');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token,
      };
      String body = json.encode(clientRequest);
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(data);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      debugPrint('Error client_request_service funcion create: $e');
      return ErrorData(e.toString());
    }
  }

  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequets(
    double originLat,
    double originLng,
    double destinationLat,
    double destinationLng,
  ) async {
    try {
      Uri url = Uri.http(
        ApiConfig.API_PROJECT,
        '/client-requests/$originLat/$originLng/$destinationLat/$destinationLng',
      );
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token,
      };
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        TimeAndDistanceValues timeAndDistanceValues =
            TimeAndDistanceValues.fromJson(data);
        return Success(timeAndDistanceValues);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      debugPrint(
        'Error client_request_service funcion getTimeAndDistanceClientRequets: $e',
      );
      return ErrorData(e.toString());
    }
  }

  // Rating Trip
  Future<Resource<bool>> updateClientRating(
      int idClientRequest, double rating) async {
    try {
      Uri url = Uri.http(
          ApiConfig.API_PROJECT, '/client-requests/update_client_rating');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      };
      String body = json.encode({
        'id': idClientRequest,
        'client_rating': rating,
      });
      final response = await http.put(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(true);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      debugPrint('Error: $e');
      return ErrorData(e.toString());
    }
  }

  Future<Resource<bool>> updateDriverRating(
      int idClientRequest, double rating) async {
    try {
      Uri url = Uri.http(
          ApiConfig.API_PROJECT, '/client-requests/update_driver_rating');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      };
      String body = json.encode({
        'id': idClientRequest,
        'driver_rating': rating,
      });
      final response = await http.put(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(true);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      debugPrint('Error: $e');
      return ErrorData(e.toString());
    }
  }



  // Actualizacion de datos y estatus ----------------------------------------------------------------------------
  Future<Resource<bool>> updateDriverAssigned(
      int idClientRequest, int idDriver, double fareAssigned) async {
    try {
      Uri url = Uri.http(
          ApiConfig.API_PROJECT, '/client-requests/updateDriverAssigned');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      };
      String body = json.encode({
        'id': idClientRequest,
        'id_driver_assigned': idDriver,
        'fare_assigned': fareAssigned
      });
      final response = await http.put(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(true);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      debugPrint('Error: $e');
      return ErrorData(e.toString());
    }
  }


  // Obtencion de datos----------------------------------------------------------------------------

  Future<Resource<List<ClientRequestResponse>>> getNearbyTripRequest( double driverLat, double driverLng,) async {
    debugPrint('DriverLat: $driverLat');
    debugPrint('DriverLng: $driverLng');
    try {
      Uri url = Uri.http(
        ApiConfig.API_PROJECT,
        '/client-requests/$driverLat/$driverLng',
      );
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token,
      };
      debugPrint('updateDriverAssigned:');
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ClientRequestResponse> clientRequests =
            ClientRequestResponse.fromJsonList(data);
        return Success(clientRequests);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e, stackTrace) {
    debugPrint('/client-requests/$driverLat/$driverLng');
    debugPrint('StackTrace: $stackTrace'); 
      debugPrint(
        'Error client_request_service funcion get nearby trip request: $e',
      );
      return ErrorData(e.toString());
    }
  }

  // Cambio de estado del client request
  Future<Resource<bool>> updateStatus(
      int idClientRequest, StatusTrip statusTrip) async {
    try {
      Uri url =
          Uri.http(ApiConfig.API_PROJECT, '/client-requests/update_status');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      };
      String body = json.encode({
        'id': idClientRequest,
        'status': statusTrip.name,
      });
      debugPrint('updateStatus: ');
      debugPrint('Body: $body');
      final response = await http.put(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(true);
      } else {
        debugPrint('Error en updateStatus: $body');
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      debugPrint('Error: $e');
      return ErrorData(e.toString());
    }
  }

  // Obtener todos los datos de una sola oferta
  Future<Resource<ClientRequestResponse>> getByClientRequest(
      int idClientRequest) async {
    try {
      Uri url = Uri.http(
          ApiConfig.API_PROJECT, '/client-requests/$idClientRequest');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      };
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        ClientRequestResponse clientRequests =
            ClientRequestResponse.fromJson(data);
        return Success(clientRequests);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      debugPrint('Error: $e');
      return ErrorData(e.toString());
    }
  }

}
