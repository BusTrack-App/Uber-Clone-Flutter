import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io_event.dart';
import 'package:uber_clone/main.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/driver_client_request_screen.dart';
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
  List<Widget> pageList = <Widget>[
    DriverMapLocationScreen(),
    DriverClientRequestScreen(),
    // ClientHistoryTripPage(),
    ProfileInfoScreen(),
    RolesScreen(),

    // RolesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu del conductor')),
      body: BlocBuilder<DriverHomeBloc, DriverHomeState>(
        builder: (context, state) {
          return pageList[state.pageIndex];
        },
      ),
      drawer: BlocBuilder<DriverHomeBloc, DriverHomeState>(
        builder: (context, state) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(255, 12, 38, 145),
                        Color.fromARGB(255, 34, 156, 249),
                      ],
                    ),
                  ),
                  child: Text(
                    'Menu del',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text('Mapa de localizacion'),
                  selected: state.pageIndex == 0,
                  onTap: () {
                    context.read<DriverHomeBloc>().add(
                      ChangeDrawerPage(pageIndex: 0),
                    );
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Solicitudes de viaje'),
                  selected: state.pageIndex == 1,
                  onTap: () {
                    context.read<DriverHomeBloc>().add(
                      ChangeDrawerPage(pageIndex: 1),
                    );
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Perfil del usuario'),
                  selected: state.pageIndex == 2,
                  onTap: () {
                    context.read<DriverHomeBloc>().add(
                      ChangeDrawerPage(pageIndex: 2),
                    );
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Roles de usuario'),
                  selected: state.pageIndex == 3,
                  onTap: () {
                    context
                        .read<DriverHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 3));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Cerrar sesion'),
                  onTap: () {
                    context.read<DriverHomeBloc>().add(Logout());
                    context.read<BlocSocketIO>().add(DisconnectSocketIO());
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(builder: (context) => MyApp()), 
                      (route) => false
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
