import 'package:flutter/material.dart';
import 'package:uber_clone/src/domain/models/user.dart';
import 'package:uber_clone/src/presentation/utils/colors.dart';
import 'package:uber_clone/src/presentation/widgets/custom_button.dart'; 
import 'package:uber_clone/src/presentation/widgets/default_image_url.dart';

class ProfileInfoContent extends StatelessWidget {
  final User? user;

  const ProfileInfoContent(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _headerProfile(context),
            const Spacer(),
            CustomButton(
              text: 'EDITAR PERFIL',
              iconData: Icons.edit,
              onPressed: () {
                Navigator.pushNamed(context, 'profile/update', arguments: user);
              },
            ),
            CustomButton(
              text: 'CERRAR SESIÓN',
              iconData: Icons.logout,
              onPressed: () {},
            ),
            const SizedBox(height: 35),
          ],
        ),
        _cardUserInfo(context),
      ],
    );
  }

  // === HEADER CON FONDO OSCURO ===
  Widget _headerProfile(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
      height: MediaQuery.of(context).size.height * 0.33,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: AppColors.backgroundDark,
      ),
      child: const Text(
        'PERFIL DE USUARIO',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 19,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  // === TARJETA DE INFORMACIÓN DEL USUARIO ===
  Widget _cardUserInfo(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 35, right: 35, top: 160),
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Card(
        color: AppColors.background,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagen de perfil
            Container(
              margin: const EdgeInsets.only(top: 25, bottom: 15),
              child: DefaultImageUrl(
                url: user?.image,
                width: 115,
              ),
            ),

            // Nombre completo
            Text(
              '${user?.name ?? ''} ${user?.lastname ?? ''}'.trim(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.backgroundDark,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),

            // Email
            Text(
              user?.email ?? 'Sin correo',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.backgroundDark,
              ),
            ),
            const SizedBox(height: 4),

            // Teléfono
            Text(
              user?.phone ?? 'Sin teléfono',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.backgroundDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

}