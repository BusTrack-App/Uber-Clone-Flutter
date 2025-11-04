
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_bloc.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_event.dart';
import 'package:uber_clone/src/presentation/screens/auth/register/bloc/register_bloc.dart';
import 'package:uber_clone/src/presentation/screens/auth/register/bloc/register_event.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBloc>(create: (context) => LoginBloc()..add(LoginInitEvent())),
  BlocProvider<RegisterBloc>(create: (context) => RegisterBloc()..add(RegisterInitEvent())),
];