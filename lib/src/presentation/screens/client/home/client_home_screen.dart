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
import 'package:uber_clone/src/presentation/screens/profile/info/bloc/profile_info_state.dart';
import 'package:uber_clone/src/presentation/screens/profile/info/bloc/profile_info_event.dart';
import 'package:uber_clone/src/presentation/screens/roles/roles_screen.dart';
import 'package:uber_clone/src/presentation/utils/colors.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  // Lista ordenada de páginas
  final List<Widget> pageList = <Widget>[
    const ProfileInfoScreen(),           // Index 0
    const ClientMapSeeckerScreen(),      // Index 1
    const ClientHistoryTripScreen(),     // Index 2
    const RolesScreen(),                 // Index 3
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
      drawer: BlocBuilder<ClientHomeBloc, ClientHomeState>(
        builder: (context, clientState) {
          return Drawer(
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Header con información del usuario
                  Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 20,
                      bottom: 20,
                      left: 16,
                      right: 16,
                    ),
                    child: BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
                      builder: (context, profileState) {
                        final user = profileState.user;

                        return GestureDetector(
                          onTap: () {
                            context
                                .read<ClientHomeBloc>()
                                .add(ChangeDrawerPage(pageIndex: 0));
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.greyMedium,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                // Foto de perfil
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: user != null
                                        ? user.image != null
                                            ? FadeInImage.assetNetwork(
                                                placeholder: 'assets/img/user_image.png',
                                                image: user.image!,
                                                fit: BoxFit.cover,
                                                fadeInDuration: const Duration(milliseconds: 500),
                                                imageErrorBuilder: (context, error, stackTrace) {
                                                  return Image.asset(
                                                    'assets/img/user_image.png',
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              )
                                            : Image.asset(
                                                'assets/img/user_image.png',
                                                fit: BoxFit.cover,
                                              )
                                        : Image.asset(
                                            'assets/img/user_image.png',
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Nombre y teléfono
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user != null
                                            ? '${user.name} ${user.lastname}'
                                            : 'Usuario',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        user?.phone ?? '',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Opciones del menú
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _buildMenuItem(
                          context: context,
                          title: 'Perfil del usuario',
                          icon: Icons.person_outline,
                          isSelected: clientState.pageIndex == 0,
                          onTap: () {
                            context
                                .read<ClientHomeBloc>()
                                .add(ChangeDrawerPage(pageIndex: 0));
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 8),
                        _buildMenuItem(
                          context: context,
                          title: 'Mapa de búsqueda',
                          icon: Icons.map_outlined,
                          isSelected: clientState.pageIndex == 1,
                          onTap: () {
                            context
                                .read<ClientHomeBloc>()
                                .add(ChangeDrawerPage(pageIndex: 1));
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 8),
                        _buildMenuItem(
                          context: context,
                          title: 'Historial de viajes',
                          icon: Icons.history,
                          isSelected: clientState.pageIndex == 2,
                          onTap: () {
                            context
                                .read<ClientHomeBloc>()
                                .add(ChangeDrawerPage(pageIndex: 2));
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 8),
                        _buildMenuItem(
                          context: context,
                          title: 'Roles de usuario',
                          icon: Icons.admin_panel_settings_outlined,
                          isSelected: clientState.pageIndex == 3,
                          onTap: () {
                            context
                                .read<ClientHomeBloc>()
                                .add(ChangeDrawerPage(pageIndex: 3));
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 8),
                        _buildMenuItem(
                          context: context,
                          title: 'Cerrar sesión',
                          icon: Icons.logout,
                          isSelected: false,
                          isLogout: true,
                          onTap: () {
                            context.read<ClientHomeBloc>().add(Logout());
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

  Widget _buildMenuItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.yellow : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isLogout
                ? Colors.redAccent.withValues(alpha: 0.3)
                : isSelected
                    ? AppColors.yellow
                    : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isLogout
                  ? Colors.redAccent
                  : isSelected
                      ? AppColors.backgroundDark
                      : Colors.grey.shade700,
              size: 22,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isLogout
                      ? Colors.redAccent
                      : isSelected
                          ? AppColors.backgroundDark
                          : Colors.black87,
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}