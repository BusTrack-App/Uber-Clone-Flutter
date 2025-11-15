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
import 'package:uber_clone/src/presentation/screens/profile/info/bloc/profile_info_bloc.dart';
import 'package:uber_clone/src/presentation/screens/profile/info/bloc/profile_info_event.dart';
import 'package:uber_clone/src/presentation/screens/roles/roles_screen.dart';
import 'package:uber_clone/src/presentation/utils/colors.dart';
import 'package:uber_clone/src/presentation/utils/menu_drawer_item.dart';
import 'package:uber_clone/src/presentation/utils/profile_card.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  final List<Widget> pageList = <Widget>[
    const DriverMapLocationScreen(),
    const DriverClientRequestScreen(),
    const DriverCarInfoScreen(),
    const DriverHistoryTripScreen(),
    const ProfileInfoScreen(),
    const RolesScreen(),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Cargar datos del usuario al iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileInfoBloc>().add(GetUserInfo());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          BlocBuilder<DriverHomeBloc, DriverHomeState>(
            builder: (context, state) {
              return pageList[state.pageIndex];
            },
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: AppColors.yellow,
              elevation: 6,
              child: const Icon(
                Icons.menu,
                color: AppColors.backgroundDark,
                size: 30,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
        ],
      ),
      drawer: BlocBuilder<DriverHomeBloc, DriverHomeState>(
        builder: (context, driverState) {
          return Drawer(
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Header con información del usuario
                  ProfileCard(
                    onTap: () {
                      context
                          .read<DriverHomeBloc>()
                          .add(ChangeDrawerPage(pageIndex: 0));
                      Navigator.pop(context);
                    },
                  ),

                  // Opciones del menú
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        MenuDrawerItem(
                          title: 'Mapa de localización',
                          icon: Icons.map_outlined,
                          isSelected: driverState.pageIndex == 0,
                          onTap: () {
                            context
                                .read<DriverHomeBloc>()
                                .add(ChangeDrawerPage(pageIndex: 0));
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 8),
                        MenuDrawerItem(
                          title: 'Solicitudes de viaje',
                          icon: Icons.directions_car_outlined,
                          isSelected: driverState.pageIndex == 1,
                          onTap: () {
                            context
                                .read<DriverHomeBloc>()
                                .add(ChangeDrawerPage(pageIndex: 1));
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 8),
                        MenuDrawerItem(
                          title: 'Mi Vehículo',
                          icon: Icons.time_to_leave_outlined,
                          isSelected: driverState.pageIndex == 2,
                          onTap: () {
                            context
                                .read<DriverHomeBloc>()
                                .add(ChangeDrawerPage(pageIndex: 2));
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 8),
                        MenuDrawerItem(
                          title: 'Historial de viajes',
                          icon: Icons.history,
                          isSelected: driverState.pageIndex == 3,
                          onTap: () {
                            context
                                .read<DriverHomeBloc>()
                                .add(ChangeDrawerPage(pageIndex: 3));
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 8),
                        MenuDrawerItem(
                          title: 'Perfil del usuario',
                          icon: Icons.person_outline,
                          isSelected: driverState.pageIndex == 4,
                          onTap: () {
                            context
                                .read<DriverHomeBloc>()
                                .add(ChangeDrawerPage(pageIndex: 4));
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 8),
                        MenuDrawerItem(
                          title: 'Roles de usuario',
                          icon: Icons.admin_panel_settings_outlined,
                          isSelected: driverState.pageIndex == 5,
                          onTap: () {
                            context
                                .read<DriverHomeBloc>()
                                .add(ChangeDrawerPage(pageIndex: 5));
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 8),
                        MenuDrawerItem(
                          title: 'Cerrar sesión',
                          icon: Icons.logout,
                          isSelected: false,
                          isLogout: true,
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
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}