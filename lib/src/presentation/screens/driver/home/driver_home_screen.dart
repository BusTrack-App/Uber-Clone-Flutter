import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io_event.dart';
import 'package:uber_clone/main.dart';
import 'package:uber_clone/src/presentation/screens/driver/carinfo/driver_car_info_screen.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/driver_client_request_screen.dart';
import 'package:uber_clone/src/presentation/screens/driver/history_trip/driver_history_trip_screen.dart';
import 'package:uber_clone/src/presentation/screens/driver/home/bloc/driver_home_bloc.dart';
import 'package:uber_clone/src/presentation/screens/driver/home/bloc/driver_home_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/home/bloc/driver_home_state.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_seeker/driver_map_location_screen.dart';
import 'package:uber_clone/src/presentation/screens/profile/info/profile_info_screen.dart';
import 'package:uber_clone/src/presentation/screens/roles/roles_screen.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  // Lista de páginas (mantén el orden que quieras mostrar)
  final List<Widget> pageList = <Widget>[
    const DriverMapLocationScreen(),
    const DriverClientRequestScreen(),
    const DriverCarInfoScreen(),
    const DriverHistoryTripScreen(),
    const ProfileInfoScreen(),
    const RolesScreen(),
  ];

  // Key para controlar el Drawer desde el FAB
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          // Contenido principal (cambia según el índice del Bloc)
          BlocBuilder<DriverHomeBloc, DriverHomeState>(
            builder: (context, state) {
              return pageList[state.pageIndex];
            },
          ),

          // Botón flotante para abrir el drawer (arriba izquierda)
          Positioned(
            top: MediaQuery.of(context).padding.top + 16, // Respeta notch/status bar
            left: 16,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              elevation: 6,
              child: const Icon(
                Icons.menu,
                color: Colors.black87,
                size: 20,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
        ],
      ),
      drawer: BlocBuilder<DriverHomeBloc, DriverHomeState>(
        builder: (context, state) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(255, 12, 38, 145),
                        Color.fromARGB(255, 34, 156, 249),
                      ],
                    ),
                  ),
                  child: const Text(
                    'Menú del Conductor',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Mapa de localización'),
                  selected: state.pageIndex == 0,
                  onTap: () {
                    context
                        .read<DriverHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 0));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Solicitudes de viaje'),
                  selected: state.pageIndex == 1,
                  onTap: () {
                    context
                        .read<DriverHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 1));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Mi Vehículo'),
                  selected: state.pageIndex == 2,
                  onTap: () {
                    context
                        .read<DriverHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 2));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Historial de viajes'),
                  selected: state.pageIndex == 3,
                  onTap: () {
                    context
                        .read<DriverHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 3));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Perfil del usuario'),
                  selected: state.pageIndex == 4,
                  onTap: () {
                    context
                        .read<DriverHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 4));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Roles de usuario'),
                  selected: state.pageIndex == 5,
                  onTap: () {
                    context
                        .read<DriverHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 5));
                    Navigator.pop(context);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.redAccent),
                  title: const Text(
                    'Cerrar sesión',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  onTap: () {
                    context.read<DriverHomeBloc>().add(Logout());
                    context.read<BlocSocketIO>().add(DisconnectSocketIO());
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MyApp()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}