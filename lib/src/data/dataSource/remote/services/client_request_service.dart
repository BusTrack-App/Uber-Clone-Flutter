import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uber_clone/src/data/api/api_config.dart';
import 'package:uber_clone/src/domain/models/time_and_distance_values.dart';
import 'package:uber_clone/src/domain/utils/list_to_string.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

class ClientRequestsService {
  Future<String> token;
  ClientRequestsService(this.token);


  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequets(
      double originLat,
      double originLng,
      double destinationLat,
      double destinationLng) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT,
          '/client-requests/$originLat/$originLng/$destinationLat/$destinationLng');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
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
      debugPrint('Error: $e');
      return ErrorData(e.toString());
    }
  }

}
