import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io_event.dart';
import 'package:uber_clone/src/domain/models/auth_response.dart';
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
            debugPrint('Error Data: ${response.message}');
          }
          else if (response is Success) {
            debugPrint('Success Dta: ${response.data}');
            final authResponse = response.data as AuthResponse;
            context.read<LoginBloc>().add(SaveUserSession(authResponse: authResponse));
            context.read<BlocSocketIO>().add(ConnectSocketIO());
            if (authResponse.user.roles!.length > 1) {
              Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
            }
            else {
              Navigator.pushNamedAndRemoveUntil(context, 'client/home', (route) => false);
            }
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
