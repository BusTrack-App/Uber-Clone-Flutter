import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_bloc.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_event.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_state.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/login_content.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    // Inicializar el formulario
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoginBloc>().add(LoginInitEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final response = state.response;
          if (response is ErrorData) {
            Fluttertoast.showToast(msg: response.message, toastLength: Toast.LENGTH_SHORT);
            debugPrint('Error: ${response.message}');
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(response.message)));
          } else if (response is Success) {
            debugPrint('Éxito: ${response.data}');
            // Aquí puedes navegar al home
            // Navigator.pushReplacementNamed(context, 'home');
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state.response is Loading) {
              return Stack(
                children: [
                  LoginContent(state),
                  const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ],
              );
            }
            return LoginContent(state);
          },
        ),
      ),
    );
  }
}
