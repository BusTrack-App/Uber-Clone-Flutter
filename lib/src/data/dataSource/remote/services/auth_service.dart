import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:uber_clone/src/data/api/api_config.dart';

class AuthService {
  Future<dynamic> login(String email, String password) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/auth/login');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      String body = json.encode({'email': email, 'password': password});
      final response = await http.post(url, headers: headers, body: body);
      debugPrint('Response: $response');
      final data = json.decode(response.body);
      debugPrint('Data: $data');
      return data;
    } catch (e) {
      debugPrint('Error $e');
    }
  }
}
