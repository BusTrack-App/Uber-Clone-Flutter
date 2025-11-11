import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:uber_clone/src/data/api/api_config.dart';
import 'package:uber_clone/src/domain/models/driver_car_info.dart';
import 'package:uber_clone/src/domain/utils/list_to_string.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

class DriverCarInfoService {
  Future<String> token;
  DriverCarInfoService(this.token);

  Future<Resource<bool>> create(DriverCarInfo driverCarInfo) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/driver-car-info');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      };
      String body = json.encode(driverCarInfo);
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

  Future<Resource<DriverCarInfo>> getDriverCarInfo(int idDriver) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/driver-car-info/$idDriver');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      };
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        DriverCarInfo driverCarInfo = DriverCarInfo.fromJson(data);
        return Success(driverCarInfo);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      debugPrint('Error: $e');
      return ErrorData(e.toString());
    }
  }
}
