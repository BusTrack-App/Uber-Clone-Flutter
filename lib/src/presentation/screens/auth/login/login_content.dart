import 'package:flutter/material.dart';
import 'package:uber_clone/src/presentation/widgets/custom_text_field.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

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
              RotatedBox(
                quarterTurns: 1,
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 60,),
              RotatedBox(
                quarterTurns: 1,
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23
                  ),
                ),
              ),
              SizedBox(height: 150,),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 60, bottom: 60),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), 
              bottomLeft: Radius.circular(35)
            )
          ),
          child: Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50,),
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
            
                Container(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/img/car.png',
                    width: 150,
                    height: 150,
                  ),
                ),
            
                Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
            
                // Campos de text
                CustomTextField(
                  text: 'Email', 
                  icon: Icons.email, 
                  onChanged: (e) {}
                ),
                CustomTextField(
                  text: 'Password', 
                  icon: Icons.key, 
                  onChanged: (e) {}
                ),

                // Boton de login
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
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
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}