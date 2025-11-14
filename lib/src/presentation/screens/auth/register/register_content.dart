import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/presentation/screens/auth/register/bloc/register_bloc.dart';
import 'package:uber_clone/src/presentation/screens/auth/register/bloc/register_event.dart';
import 'package:uber_clone/src/presentation/screens/auth/register/bloc/register_state.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/driver_client_request_item.dart';
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';
import 'package:uber_clone/src/presentation/widgets/custom_button.dart';
import 'package:uber_clone/src/presentation/widgets/custom_text_fiel_outlined.dart';


class RegisterContent extends StatelessWidget {

  RegisterState state;

  RegisterContent(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              color: AppColors.backgroundDark
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // HORIZONTAL
              mainAxisAlignment: MainAxisAlignment.center, // VERTICAL
              children: [
                _textLoginRotated(context),
                SizedBox(height: 100),
                _textRegisterRotated(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 60, bottom: 35),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                bottomLeft: Radius.circular(35)
              ),
              color: AppColors.greyLight
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      _imageBanner(),
                      CustomTextFielOutlined(
                        text: 'Nombre', 
                        icon: Icons.person_outline,
                        margin: EdgeInsets.only(left: 50, right: 50, top: 50),
                        onChanged: (text) {
                          context.read<RegisterBloc>().add(NameChanged(name: BlocFormItem(value: text)));
                        },
                        validator: (value) {
                          return state.name.error;
                        },
                      ),
                      CustomTextFielOutlined(
                        text: 'Apellido', 
                        icon: Icons.person_2_outlined,
                        margin: EdgeInsets.only(left: 50, right: 50, top: 15),
                        onChanged: (text) {
                          context.read<RegisterBloc>().add(LastnameChanged(lastname: BlocFormItem(value: text)));
                        },
                        validator: (value) {
                          return state.lastname.error;
                        },
                      ),
                      CustomTextFielOutlined(
                        text: 'Email', 
                        icon: Icons.email_outlined,
                        margin: EdgeInsets.only(left: 50, right: 50, top: 15),
                        onChanged: (text) {
                          context.read<RegisterBloc>().add(EmailChanged(email: BlocFormItem(value: text)));
                        },
                        validator: (value) {
                          return state.email.error;
                        },
                      ),
                      CustomTextFielOutlined(
                        text: 'Telefono', 
                        icon: Icons.phone_outlined,
                        margin: EdgeInsets.only(left: 50, right: 50, top: 15),
                        onChanged: (text) {
                          context.read<RegisterBloc>().add(PhoneChanged(phone: BlocFormItem(value: text)));
                        },
                        validator: (value) {
                          return state.phone.error;
                        },
                      ),
                      CustomTextFielOutlined(
                        text: 'Password', 
                        icon: Icons.lock_outlined,
                        margin: EdgeInsets.only(left: 50, right: 50, top: 15),
                        onChanged: (text) {
                          context.read<RegisterBloc>().add(PasswordChanged(password: BlocFormItem(value: text)));
                        },
                        validator: (value) {
                          return state.password.error;
                        },
                      ),
                      CustomTextFielOutlined(
                        text: 'Confirmar Password', 
                        icon: Icons.lock_outlined,
                        margin: EdgeInsets.only(left: 50, right: 50, top: 15),
                        onChanged: (text) {
                          context.read<RegisterBloc>().add(ConfirmPasswordChanged(confirmPassword: BlocFormItem(value: text)));
                        },
                        validator: (value) {
                          return state.confirmPassword.error;
                        },
                      ),
                      CustomButton(
                        onPressed: () {
                          if (state.formKey!.currentState!.validate()) {
                            context.read<RegisterBloc>().add(FormSubmit());
                            context.read<RegisterBloc>().add(FormReset());
                          }
                        },
                        text: 'Crear usuario',
                        margin: EdgeInsets.only(top: 30 ,left: 60 ,right: 60),
                      ),
                      SizedBox(height: 25),
                      _separatorOr(),
                       SizedBox(height: 10),
                      _textIAlreadyHaveAccount(context)
                    ],
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _textIAlreadyHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Ya tienes cuenta?',
          style: TextStyle(
            color: AppColors.backgroundDark,
            fontSize: 16
          ),
        ),
        SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            'Inicia sesion',
            style: TextStyle(
              color: AppColors.backgroundDark,
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
        ),
      ],
    );
  }

  Widget _separatorOr() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 25,
          height: 1,
          color: Colors.white,
          margin: EdgeInsets.only(right: 5),
        ),
        Text(
          'O',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17
          ),
        ),
         Container(
          width: 25,
          height: 1,
          color: Colors.white,
          margin: EdgeInsets.only(left: 5),
        ),
      ],
    );
  }

  Widget _imageBanner() {
    return Container(
      margin: EdgeInsets.only(top: 60),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/img/trip.png',
        width: 180,
        height: 180,
      ),
    );
  }

  Widget _textRegisterRotated() {
    return RotatedBox(
      quarterTurns: 1,
      child: Text(
        'Registro',
        style: TextStyle(
          fontSize: 27,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _textLoginRotated(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: RotatedBox(
        quarterTurns: 1,
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}