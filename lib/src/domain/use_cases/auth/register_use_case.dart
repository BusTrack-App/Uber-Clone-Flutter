import 'package:uber_clone/src/domain/models/user.dart';
import 'package:uber_clone/src/domain/repository/auth_repository.dart';

class RegisterUseCase {

  AuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  run(User user) => authRepository.register(user);
}