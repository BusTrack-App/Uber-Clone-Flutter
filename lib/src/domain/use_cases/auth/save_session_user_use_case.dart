// import 'package:uber_clone/src/domain/models/auth_response.dart';
import 'package:uber_clone/src/domain/repository/auth_repository.dart';

class SaveUserSessionUseCase {

  AuthRepository authRepository;

  SaveUserSessionUseCase(this.authRepository);

  // run(AuthResponse authResponse) => authRepository.saveUserSession(authResponse);

}