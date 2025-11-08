import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:uber_clone/src/data/api/api_config.dart';
import 'package:uber_clone/src/domain/models/auth_response.dart';
import 'package:uber_clone/src/domain/models/user.dart';
import 'package:uber_clone/src/domain/utils/list_to_string.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

class AuthService {
  Future<Resource<AuthResponse>> login(String email, String password) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/auth/login');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      String body = json.encode({'email': email, 'password': password});
      final response = await http.post(url, headers: headers, body: body);
      debugPrint('Response: $response');
      final data = json.decode(response.body);
      debugPrint('Data: $data');
      debugPrint('Status Coode: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);
        debugPrint('Data Remote: ${authResponse.toJson()}');
        debugPrint('Token: ${authResponse.token}');
        return Success(authResponse);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      debugPrint('Error auth_service en funcion login: $e');
      return ErrorData(e.toString());
    }
  }

  Future<Resource<AuthResponse>> register(User user) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/auth/register');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      String body = json.encode(user);
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);
        debugPrint('Data Remote: ${authResponse.toJson()}');
        debugPrint('Token: ${authResponse.token}');
        return Success(authResponse);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      debugPrint('Error auth_service en funcion register: $e');
      return ErrorData(e.toString());
    }
  }
}
