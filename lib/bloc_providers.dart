import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io.dart';
import 'package:uber_clone/injection.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/client_requests_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/driver-car-info/driver_car_info_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/driver-trip-request/driver_trip_request_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/drivers-position/drivers_position_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/geolocator_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/socket/socket_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/users/user_use_case.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_bloc.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/bloc/login_event.dart';
import 'package:uber_clone/src/presentation/screens/auth/register/bloc/register_bloc.dart';
import 'package:uber_clone/src/presentation/screens/auth/register/bloc/register_event.dart';
import 'package:uber_clone/src/presentation/screens/client/driver_offers/bloc/client_driver_offers_bloc.dart';
import 'package:uber_clone/src/presentation/screens/client/home/bloc/client_home_bloc.dart';
import 'package:uber_clone/src/presentation/screens/client/map_booking_info/bloc/client_map_booking_info_bloc.dart';
import 'package:uber_clone/src/presentation/screens/client/map_seeker/bloc/client_map_seeker_bloc.dart.dart';
import 'package:uber_clone/src/presentation/screens/client/map_trip/bloc/client_map_trip_bloc.dart';
import 'package:uber_clone/src/presentation/screens/driver/carinfo/bloc/driver_car_info_bloc.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/bloc/driver_client_request_bloc.dart';
import 'package:uber_clone/src/presentation/screens/driver/home/bloc/driver_home_bloc.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_seeker/bloc/driver_map_location_bloc.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_trip/bloc/driver_map_trip_bloc.dart';
import 'package:uber_clone/src/presentation/screens/profile/info/bloc/profile_info_bloc.dart';
import 'package:uber_clone/src/presentation/screens/profile/info/bloc/profile_info_event.dart';
import 'package:uber_clone/src/presentation/screens/profile/update/bloc/profile_update_bloc.dart';
import 'package:uber_clone/src/presentation/screens/roles/bloc/roles_bloc.dart';
import 'package:uber_clone/src/presentation/screens/roles/bloc/roles_event.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBloc>(
    create: (context) =>
        LoginBloc(locator<AuthUseCases>())..add(LoginInitEvent()),
  ),
  BlocProvider<RegisterBloc>(
    create: (context) =>
        RegisterBloc(locator<AuthUseCases>())..add(RegisterInitEvent()),
  ),

  // Bloc para la conexion del socket ------
  BlocProvider<BlocSocketIO>(
    create: (context) =>
        BlocSocketIO(locator<SocketUseCases>(), locator<AuthUseCases>()),
  ),

  // Vista del Home
  BlocProvider<ClientHomeBloc>(
    create: (context) => ClientHomeBloc(locator<AuthUseCases>()),
  ),
  BlocProvider<DriverHomeBloc>(
    create: (context) => DriverHomeBloc(locator<AuthUseCases>()),
  ),
  BlocProvider<RolesBloc>(
    create: (context) =>
        RolesBloc(locator<AuthUseCases>())..add(GetRolesList()),
  ),

  // Vista del Perfil
  BlocProvider<ProfileInfoBloc>(
    create: (context) =>
        ProfileInfoBloc(locator<AuthUseCases>())..add(GetUserInfo()),
  ),
  BlocProvider<ProfileUpdateBloc>(
    create: (context) =>
        ProfileUpdateBloc(locator<UsersUseCases>(), locator<AuthUseCases>()),
  ),

  // Uso de mapas
  BlocProvider<ClientMapSeekerBloc>(
    create: (context) => ClientMapSeekerBloc(
      context.read<BlocSocketIO>(),
      locator<GeolocatorUseCases>(),
      locator<SocketUseCases>(),
    ),
  ),
  BlocProvider<ClientMapBookingInfoBloc>(
    create: (context) => ClientMapBookingInfoBloc(
      context.read<BlocSocketIO>(),
      locator<GeolocatorUseCases>(),
      locator<ClientRequestsUseCases>(),
      locator<AuthUseCases>(),
    ),
  ),
  BlocProvider<DriverMapLocationBloc>(
    create: (context) => DriverMapLocationBloc(
      context.read<BlocSocketIO>(),
      locator<GeolocatorUseCases>(),
      locator<SocketUseCases>(),
      locator<AuthUseCases>(),
      locator<DriversPositionUseCases>(),
    ),
  ),
  BlocProvider<DriverClientRequestsBloc>(
    create: (context) => DriverClientRequestsBloc(
      context.read<BlocSocketIO>(),
      locator<ClientRequestsUseCases>(),
      locator<DriversPositionUseCases>(),
      locator<AuthUseCases>(),
      locator<DriverTripRequestUseCases>(),
    ),
  ),
  BlocProvider<ClientDriverOffersBloc>(
    create: (context) => ClientDriverOffersBloc(
      context.read<BlocSocketIO>(),
      locator<DriverTripRequestUseCases>(),
      locator<ClientRequestsUseCases>(),
    ),
  ),

  // ------- CAR INFO
  BlocProvider<DriverCarInfoBloc>(
    create: (context) => DriverCarInfoBloc(
      locator<AuthUseCases>(),
      locator<DriverCarInfoUseCases>(),
    ),
  ),

  // Maps Trips
  BlocProvider<ClientMapTripBloc>(
    create: (context) => ClientMapTripBloc(
      context.read<BlocSocketIO>(),
      locator<ClientRequestsUseCases>(),
      locator<GeolocatorUseCases>(),
      locator<AuthUseCases>(),
    ),
  ),

  BlocProvider<DriverMapTripBloc>(
    create: (context) => DriverMapTripBloc(
      context.read<BlocSocketIO>(),
      locator<ClientRequestsUseCases>(),
      locator<GeolocatorUseCases>(),
    ),
  ),
];
