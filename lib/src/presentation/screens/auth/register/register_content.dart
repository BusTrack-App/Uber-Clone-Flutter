import 'package:flutter/material.dart';
import 'package:uber_clone/src/presentation/widgets/custom_button.dart';
import 'package:uber_clone/src/presentation/widgets/custom_text_fiel_outlined.dart';

class RegisterContent extends StatelessWidget {
  const RegisterContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.blueAccent,
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
               onTap: () {
                  Navigator.pushNamed(context, 'login');
                },
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60),
              RotatedBox(
                quarterTurns: 1,
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 150),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 60, bottom: 60),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              bottomLeft: Radius.circular(35),
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),

                Container(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/img/car.png',
                    width: 150,
                    height: 150,
                  ),
                ),

                Text('Register', style: TextStyle(fontSize: 20)),

                // Campos de text
                CustomTextFielOutlined(
                  text: 'Nombre',
                  icon: Icons.email,
                  onChanged: (e) {},
                ),
                CustomTextFielOutlined(
                  text: 'Apellido',
                  icon: Icons.email,
                  onChanged: (e) {},
                ),
                CustomTextFielOutlined(
                  text: 'Email',
                  icon: Icons.email,
                  onChanged: (e) {},
                ),
                CustomTextFielOutlined(
                  text: 'Telefono',
                  icon: Icons.email,
                  onChanged: (e) {},
                ),
                CustomTextFielOutlined(
                  text: 'Password',
                  icon: Icons.key,
                  onChanged: (e) {},
                ),
                CustomTextFielOutlined(
                  text: 'Confirm Password',
                  icon: Icons.key,
                  onChanged: (e) {},
                ),

                // Boton de login
                CustomButton(text: 'Crear Usuario', onPressed: () {}),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
