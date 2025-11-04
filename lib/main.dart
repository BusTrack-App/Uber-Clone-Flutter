import 'package:flutter/material.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/login_screen.dart';
import 'package:uber_clone/src/presentation/screens/auth/register/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginScreen(),
        'register': (BuildContext context) => RegisterScreen(),
      },
      // home: const LoginScreen(),
    );
  }
}

