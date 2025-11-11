import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/bloc_providers.dart';
import 'package:uber_clone/injection.dart';
import 'package:uber_clone/src/presentation/screens/auth/login/login_screen.dart';
import 'package:uber_clone/src/presentation/screens/auth/register/register_screen.dart';
import 'package:uber_clone/src/presentation/screens/client/driver_offers/client_driver_offers_screen.dart';
import 'package:uber_clone/src/presentation/screens/client/home/client_home_screen.dart';
import 'package:uber_clone/src/presentation/screens/client/map_booking_info/client_map_booking_info_screen.dart';
import 'package:uber_clone/src/presentation/screens/client/map_trip/client_map_trip_screen.dart';
import 'package:uber_clone/src/presentation/screens/driver/home/driver_home_screen.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_trip/driver_map_trip_screen.dart';
import 'package:uber_clone/src/presentation/screens/profile/update/profile_update_screen.dart';
import 'package:uber_clone/src/presentation/screens/roles/roles_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        builder: FToastBuilder(),
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginScreen(),
          'register': (BuildContext context) => RegisterScreen(),
          'roles': (BuildContext context) => RolesScreen(),
          'client/home': (BuildContext context) => ClientHomeScreen(),
          'driver/home': (BuildContext context) => DriverHomeScreen(),
          'profile/update': (BuildContext context) => ProfileUpdateScreen(),

          // Mapas
          'client/map/booking': (BuildContext context) => ClientMapBookingInfoScreen(),
          'client/driver/offers': (BuildContext context) => ClientDriverOffersScreen(),

          // Maps Trip
          'client/map/trip': (BuildContext context) => ClientMapTripScreen(),
          'driver/map/trip': (BuildContext context) => DriverMapTripScreen(),

        },
      ),
    );
  }
}
