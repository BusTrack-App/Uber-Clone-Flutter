import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LoginState extends Equatable {
  final GlobalKey<FormState>? formKey;
  final String email;
  final String password;

  const LoginState({this.email = '', this.password = '', this.formKey});

  LoginState copyWith({
    String? email,
    String? password,
    GlobalKey<FormState>? formKey,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formKey: formKey ?? this.formKey,
    );
  }

  @override
  List<Object?> get props => [email, password];
}
