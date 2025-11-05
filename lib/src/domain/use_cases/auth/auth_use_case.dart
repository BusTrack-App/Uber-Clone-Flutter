import 'package:uber_clone/src/domain/use_cases/auth/get_user_session_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/auth/login_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/auth/register_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/auth/save_session_user_use_case.dart';


class AuthUseCases {

  LoginUseCase login;
  RegisterUseCase register;
  SaveUserSessionUseCase saveUserSession;
  GetUserSessionUseCase getUserSession;
  // LogoutUseCase logout;

  AuthUseCases({
    required this.login,
    required this.register,
    required this.saveUserSession,
    required this.getUserSession,
    // required this.logout,
  });

}