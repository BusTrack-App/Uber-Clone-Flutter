import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/models/user.dart';
import 'package:uber_clone/src/presentation/screens/profile/update/bloc/profile_update_bloc.dart';
import 'package:uber_clone/src/presentation/screens/profile/update/bloc/profile_update_event.dart';
import 'package:uber_clone/src/presentation/screens/profile/update/bloc/profile_update_state.dart';
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';
import 'package:uber_clone/src/presentation/utils/gallery_or_photo_dialog.dart';
import 'package:uber_clone/src/presentation/widgets/custom_text_field.dart';
import 'package:uber_clone/src/presentation/widgets/default_icon_back.dart';

class ProfileUpdateContent extends StatelessWidget {

  User? user;
  ProfileUpdateState state;

  ProfileUpdateContent(this.state, this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Stack(
        children: [
          Column(
            children: [
              _headerProfile(context),
              Spacer(),
              _actionProfile(context, 'ACTUALIZAR USUARIO', Icons.check),
              SizedBox(height: 35,)
            ],
          ),
          _cardUserInfo(context),
          DefaultIconBack(
            margin: EdgeInsets.only(top: 60, left: 30),
          )
        ],
      ),
    );
  }
  Widget _imageUser(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GalleryOrPhotoDialog(
          context, 
          () => { context.read<ProfileUpdateBloc>().add(PickImage()) }, 
          () => { context.read<ProfileUpdateBloc>().add(TakePhoto()) }
        );
        
      },
      child: Container(
        width: 115,
        margin: EdgeInsets.only(top: 50, bottom: 15),
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipOval(
            child: state.image != null 
            ? Image.file(
              state.image!,
              fit: BoxFit.cover,
            )
            : user != null 
              ? user!.image != null 
                ? FadeInImage.assetNetwork(
                  placeholder: 'assets/img/user_image.png', 
                  image: user!.image!,
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(seconds: 1),
                )
                : 
                Image.asset(
                  'assets/img/user_image.png',
                )
              : Image.asset(
                'assets/img/user_image.png',
              ),
          ),
        ),
      ),
    );
  }

  Widget _cardUserInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, right: 35, top: 150),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Column(
          children: [
            _imageUser(context),
            CustomTextField(
              text: 'Nombre', 
              icon: Icons.person, 
              margin: EdgeInsets.only(left: 30, right: 30, top: 15),
              backgroundColor: Colors.grey[200]!,
              initialValue: user?.name,
              onChanged: (text) {
                context.read<ProfileUpdateBloc>().add(NameChanged(name: BlocFormItem(value: text)));
              },
              validator: (value) {
                return state.name.error;
              },
            ),
            CustomTextField(
              text: 'Apellido', 
              icon: Icons.person_outline, 
              backgroundColor: Colors.grey[200]!,
              initialValue: user?.lastname,
              margin: EdgeInsets.only(left: 30, right: 30, top: 15),
              onChanged: (text) {
                context.read<ProfileUpdateBloc>().add(LastNameChanged(lastname: BlocFormItem(value: text)));
              },
              validator: (value) {
                return state.lastname.error;
              },
            ),
            CustomTextField(
              text: 'Telefono', 
              icon: Icons.phone,
              initialValue: user?.phone,
              margin: EdgeInsets.only(left: 30, right: 30, top: 15),
              backgroundColor: Colors.grey[200]!, 
              onChanged: (text) {
                context.read<ProfileUpdateBloc>().add(PhoneChanged(phone: BlocFormItem(value: text)));
              },
              validator: (value) {
                return state.phone.error;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionProfile(BuildContext context, String option, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (state.formKey!.currentState != null) {
          if (state.formKey!.currentState!.validate()) {
            context.read<ProfileUpdateBloc>().add(FormSubmit());
          }
        }
        else {
          context.read<ProfileUpdateBloc>().add(FormSubmit());
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 15),
        child: ListTile(
          title: Text(
            option,
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          leading: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 19, 58, 213),
                  Color.fromARGB(255, 65, 173, 255),
                ]
              ),
              borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerProfile(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 70),
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 19, 58, 213),
                Color.fromARGB(255, 65, 173, 255),
          ]
        ),
      ),
      child: Text(
        'PERFIL DE USUARIO',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 19
        ),
      ),
    );
  }
}