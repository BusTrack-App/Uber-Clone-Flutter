import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/src/domain/models/user.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/profile/info/bloc/profile_info_bloc.dart';
import 'package:uber_clone/src/presentation/screens/profile/info/bloc/profile_info_event.dart';
import 'package:uber_clone/src/presentation/screens/profile/update/bloc/profile_update_bloc.dart';
import 'package:uber_clone/src/presentation/screens/profile/update/bloc/profile_update_event.dart';
import 'package:uber_clone/src/presentation/screens/profile/update/bloc/profile_update_state.dart';
import 'package:uber_clone/src/presentation/screens/profile/update/profile_update_content.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  User? user;

  @override
  void initState() {
    // PRIMER EVENTO EN DISPARARSE - UNA SOLA VEZ
    super.initState();
    debugPrint('METODO INIT STATE');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      debugPrint('METODO INIT STATE BINDING');
      context.read<ProfileUpdateBloc>().add(ProfileUpdateInitEvent(user: user));
    });
  }

  @override
  Widget build(BuildContext context) {
    // SEGUNDO - CTRL + S
    debugPrint('METODO BUILD');
    user = ModalRoute.of(context)?.settings.arguments as User;
    return Scaffold(
      body: BlocListener<ProfileUpdateBloc, ProfileUpdateState>(
        listener: (context, state) {
          final response = state.response;
          if (response is ErrorData) {
            Fluttertoast.showToast(msg: response.message, toastLength: Toast.LENGTH_LONG);
          }
          else if (response is Success) {
            User user = response.data as User;
            Fluttertoast.showToast(msg: 'Actualizacion exitosa', toastLength: Toast.LENGTH_LONG);
            context.read<ProfileUpdateBloc>().add(UpdateUserSession(user: user));
            Future.delayed(Duration(seconds: 1), () {
              // ignore: use_build_context_synchronously
              context.read<ProfileInfoBloc>().add(GetUserInfo());
            });
          }
        },
        child: BlocBuilder<ProfileUpdateBloc, ProfileUpdateState>(
          builder: (context, state) {
            final response = state.response;
            if (response is Loading) {
              return Stack(
                children: [
                  ProfileUpdateContent(state, user),
                  Center(child: CircularProgressIndicator())
                ],
              );
            }
            return ProfileUpdateContent(state, user);
          },
        ),
      ),
    );
  }
}
