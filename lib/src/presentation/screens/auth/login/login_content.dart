import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_bloc.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_event.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_state.dart';
import 'package:uber_clone/src/presentation/widgets/custom_button.dart';
import 'package:uber_clone/src/presentation/widgets/custom_text_field.dart';

class LoginContent extends StatelessWidget {
  final LoginState state;

  const LoginContent(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.blueAccent,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'register');
                  },
                  child: const RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                  ),
                ),
                const SizedBox(height: 150),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 60, bottom: 60),
            decoration: const BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                bottomLeft: Radius.circular(35),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  const Text('Welcome', style: TextStyle(fontSize: 25)),
                  const Text('back...', style: TextStyle(fontSize: 25)),
                  const SizedBox(height: 20),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'assets/img/car.png',
                      width: 150,
                      height: 150,
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Text('Log In', style: TextStyle(fontSize: 20)),

                  const SizedBox(height: 20),

                  // Email Field
                  CustomTextField(
                    text: 'Email',
                    icon: Icons.email,
                    onChanged: (text) {
                      context.read<LoginBloc>().add(EmailChanged(email: text));
                    },
                    validator: (value) {
                      return state.email.error;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Password Field
                  CustomTextField(
                    text: 'Password',
                    icon: Icons.key,
                    obscureText: true,
                    onChanged: (text) {
                      context.read<LoginBloc>().add(PasswordChanged(
                        password: text, // ← String, no BlocFormItem
                      ));
                    },
                    validator: (value) {
                      return state.password.error;
                    },
                  ),

                  const SizedBox(height: 30),

                  // Login Button
                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      if (state.formKey!.currentState!.validate()) {
                        context.read<LoginBloc>().add(FormSubmit());
                      } else {
                        debugPrint('El formulario no es válido');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}