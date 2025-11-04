import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_bloc.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_state.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/login_content.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      // backgroundColor: Colors.lightBlue,
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return LoginContent(_bloc);
        },
      ),
    );
  }
}
