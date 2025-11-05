
import 'package:uber_clone/src/domain/repository/auth_repository.dart';

class LogoutUseCase {

  AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  run() => authRepository.logout();

}