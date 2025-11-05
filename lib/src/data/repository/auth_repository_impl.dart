

import 'package:uber_clone/src/data/dataSource/local/shared_pref.dart';
import 'package:uber_clone/src/data/dataSource/remote/services/auth_service.dart';
import 'package:uber_clone/src/domain/models/auth_response.dart';
import 'package:uber_clone/src/domain/models/user.dart';
import 'package:uber_clone/src/domain/repository/auth_repository.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

class AuthRepositoryImpl implements AuthRepository {
  
  AuthService authService;
  SharedPref sharefPref;

  AuthRepositoryImpl(this.authService, this.sharefPref);

  @override
  Future<Resource<AuthResponse>> login(String email, String password) {
    return authService.login(email, password);
  }

  @override
  Future<Resource<AuthResponse>> register(User user) {
    return authService.register(user);
  }
  
  @override
  Future<AuthResponse?> getUserSession() async {
    final data = await sharefPref.read('user');
    if (data != null) {
      AuthResponse authResponse = AuthResponse.fromJson(data);
      return authResponse;
    }
    return null;
  }
  
  @override
  Future<void> saveUserSession(AuthResponse authResponse) async {
    sharefPref.save('user', authResponse.toJson());
  }
  
  @override
  Future<bool> logout() async {
    return await sharefPref.remove('user');
  }

}