import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io_event.dart';
import 'package:uber_clone/main.dart';
import 'package:uber_clone/src/presentation/screens/client/history_trip/client_history_trip_screen.dart';
import 'package:uber_clone/src/presentation/screens/client/home/bloc/client_home_bloc.dart';
import 'package:uber_clone/src/presentation/screens/client/home/bloc/client_home_event.dart';
import 'package:uber_clone/src/presentation/screens/client/home/bloc/client_home_state.dart';
import 'package:uber_clone/src/presentation/screens/client/map_seeker/client_map_seecker_screen.dart';
import 'package:uber_clone/src/presentation/screens/profile/info/profile_info_screen.dart';
import 'package:uber_clone/src/presentation/screens/profile/info/bloc/profile_info_bloc.dart';
import 'package:uber_clone/src/presentation/screens/profile/info/bloc/profile_info_event.dart';
import 'package:uber_clone/src/presentation/screens/roles/roles_screen.dart';
import 'package:uber_clone/src/presentation/utils/colors.dart';
import 'package:uber_clone/src/presentation/utils/menu_drawer_item.dart';
import 'package:uber_clone/src/presentation/utils/profile_card.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  // Lista ordenada de páginas
  final List<Widget> pageList = <Widget>[
    const ClientMapSeeckerScreen(), // Index 1
    const ClientHistoryTripScreen(), // Index 2
    const ProfileInfoScreen(), // Index 0
    const RolesScreen(), // Index 3
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
          BlocBuilder<ClientHomeBloc, ClientHomeState>(
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
              elevation: 0,
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
      drawer: BlocBuilder<ClientHomeBloc, ClientHomeState>(
        builder: (context, clientState) {
          return Drawer(
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Header con información del usuario
                  ProfileCard(
                    onTap: () {
                      context.read<ClientHomeBloc>().add(
                        ChangeDrawerPage(pageIndex: 0),
                      );
                      Navigator.pop(context);
                    },
                  ),

                  // Opciones del menú
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        MenuDrawerItem(
                          title: 'Mapa de búsqueda',
                          icon: Icons.map_outlined,
                          isSelected: clientState.pageIndex == 0,
                          onTap: () {
                            context.read<ClientHomeBloc>().add(
                              ChangeDrawerPage(pageIndex: 0),
                            );
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 8),
                        MenuDrawerItem(
                          title: 'Historial de viajes',
                          icon: Icons.history,
                          isSelected: clientState.pageIndex == 1,
                          onTap: () {
                            context.read<ClientHomeBloc>().add(
                              ChangeDrawerPage(pageIndex: 1),
                            );
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 8),
                        MenuDrawerItem(
                          title: 'Perfil del usuario',
                          icon: Icons.person_outline,
                          isSelected: clientState.pageIndex == 2,
                          onTap: () {
                            context.read<ClientHomeBloc>().add(
                              ChangeDrawerPage(pageIndex: 2),
                            );
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 8),
                        MenuDrawerItem(
                          title: 'Roles de usuario',
                          icon: Icons.admin_panel_settings_outlined,
                          isSelected: clientState.pageIndex == 3,
                          onTap: () {
                            context.read<ClientHomeBloc>().add(
                              ChangeDrawerPage(pageIndex: 3),
                            );
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
                            context.read<ClientHomeBloc>().add(Logout());
                            context.read<BlocSocketIO>().add(
                              DisconnectSocketIO(),
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyApp(),
                              ),
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
