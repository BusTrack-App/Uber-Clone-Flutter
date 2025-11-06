
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/injection.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/geolocator_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/users/user_use_case.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_bloc.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_event.dart';
import 'package:uber_clone/src/presentation/screens/auth/register/bloc/register_bloc.dart';
import 'package:uber_clone/src/presentation/screens/auth/register/bloc/register_event.dart';
import 'package:uber_clone/src/presentation/screens/client/home/bloc/client_home_bloc.dart';
import 'package:uber_clone/src/presentation/screens/client/map_seeker/bloc/client_map_seeker_bloc.dart.dart';
import 'package:uber_clone/src/presentation/screens/profile/info/bloc/profile_info_bloc.dart';
import 'package:uber_clone/src/presentation/screens/profile/info/bloc/profile_info_event.dart';
import 'package:uber_clone/src/presentation/screens/profile/update/bloc/profile_update_bloc.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBloc>(create: (context) => LoginBloc(locator<AuthUseCases>())..add(LoginInitEvent())),
  BlocProvider<RegisterBloc>(create: (context) => RegisterBloc(locator<AuthUseCases>())..add(RegisterInitEvent())),

  // Vista del Home
  BlocProvider<ClientHomeBloc>(create: (context) => ClientHomeBloc(locator<AuthUseCases>())),

  // Vista del Perfil
  BlocProvider<ProfileInfoBloc>(create: (context) => ProfileInfoBloc(locator<AuthUseCases>())..add(GetUserInfo())),
  BlocProvider<ProfileUpdateBloc>(create: (context) => ProfileUpdateBloc(locator<UsersUseCases>(), locator<AuthUseCases>())),

  // Uso de mapas
  BlocProvider<ClientMapSeekerBloc>(create: (context) => ClientMapSeekerBloc(locator<GeolocatorUseCases>())),

];