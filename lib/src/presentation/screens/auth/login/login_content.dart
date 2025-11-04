import 'package:flutter/material.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome',
            style: TextStyle(
              fontSize: 25
            ),
          ),
          Text(
            'back...',
            style: TextStyle(
              fontSize: 25
            ),
          ),
          Text(
            'Log In',
            style: TextStyle(
              fontSize: 20
            ),
          ),

          // Campos de text
          TextFormField(
            decoration: InputDecoration(
              label: Text('Email'),
              prefixIcon: Icon(Icons.email_outlined)
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              label: Text('Password'),
              prefixIcon: Icon(Icons.key)
            ),
          ),

          // Boton de login
          ElevatedButton(
            onPressed: () {}, 
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            child: Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white
              ),
            )
          )
        ],
      ),
    );
  }
}