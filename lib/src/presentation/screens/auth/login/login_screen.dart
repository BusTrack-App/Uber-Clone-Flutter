import 'package:flutter/material.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/login_content.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.lightBlue,
      body: LoginContent()
    );
  }
}