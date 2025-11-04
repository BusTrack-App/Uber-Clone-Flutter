import 'package:flutter/material.dart';
import 'package:uber_clone/src/presentation/screens/auth/register/register_content.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterContent(),
    );
  }
}