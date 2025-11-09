import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:uber_clone/src/data/api/api_config.dart';
import 'package:uber_clone/src/domain/models/driver_trip_request.dart';
import 'package:uber_clone/src/domain/utils/list_to_string.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

class DriverTripRequestsService {
  Future<String> token;
  DriverTripRequestsService(this.token);

  Future<Resource<bool>> create(
    DriverTripRequest driverTripRequest,
  ) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/driver-trip-offers');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token,
      };
      String body = json.encode(driverTripRequest);
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('${driverTripRequest.toJson()}');
        return Success(true);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      debugPrint('Error: $e');
      return ErrorData(e.toString());
    }
  }

  Future<Resource<List<DriverTripRequest>>> getDriverTripOffersByClientRequest(
    int idClientRequest,
  ) async {
    try {
      Uri url = Uri.http(
        ApiConfig.API_PROJECT,
        '/driver-trip-offers/findByClientRequest/$idClientRequest',
      );
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token,
      };
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<DriverTripRequest> driverTripRequest =
            DriverTripRequest.fromJsonList(data);
        return Success(driverTripRequest);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      debugPrint('Error: $e');
      return ErrorData(e.toString());
    }
  }
}
