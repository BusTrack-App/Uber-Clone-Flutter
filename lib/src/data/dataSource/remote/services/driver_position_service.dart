import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:uber_clone/src/data/api/api_config.dart';
import 'package:uber_clone/src/domain/models/driver_position.dart';
import 'package:uber_clone/src/domain/utils/list_to_string.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';


class DriversPositionService {
  Future<String> token;
  DriversPositionService(this.token);

  Future<Resource<bool>> create(DriverPosition driverPosition) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/drivers-position');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      };
      String body = json.encode(driverPosition);
      final response = await http.post(url, headers: headers, body: body);
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

  Future<Resource<bool>> delete(int idDriver) async {
    try {
      Uri url =
          Uri.http(ApiConfig.API_PROJECT, '/drivers-position/$idDriver');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      };
      final response = await http.delete(url, headers: headers);
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
}
