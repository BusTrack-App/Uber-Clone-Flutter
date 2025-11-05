import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/src/domain/models/auth_response.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/auth/register/bloc/register_bloc.dart';
import 'package:uber_clone/src/presentation/screens/auth/register/bloc/register_event.dart';
import 'package:uber_clone/src/presentation/screens/auth/register/bloc/register_state.dart';
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
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          final response = state.response;
          if (response is ErrorData) {
            Fluttertoast.showToast(msg: response.message, toastLength: Toast.LENGTH_LONG);
          }
          else if (response is Success) {
            final authResponse = response.data as AuthResponse;
            context.read<RegisterBloc>().add(FormReset());
            context.read<RegisterBloc>().add(SaveUserSession(authResponse: authResponse));
            Navigator.pushNamedAndRemoveUntil(context, 'client/home', (route) => false);
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return RegisterContent(state);
          },
        ),
      ),
    );
  }
}
