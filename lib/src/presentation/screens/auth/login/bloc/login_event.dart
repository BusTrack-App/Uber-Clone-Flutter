import 'package:uber_clone/src/domain/models/auth_response.dart';

abstract class LoginEvent {}

class LoginInitEvent extends LoginEvent {}

class EmailChanged extends LoginEvent {
  final String email;
  EmailChanged({required this.email});
}

class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged({required this.password});
}

class SaveUserSession extends LoginEvent {
  final AuthResponse authResponse;
  SaveUserSession({ required this.authResponse });
}

class FormSubmit extends LoginEvent {}