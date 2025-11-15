import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/presentation/screens/profile/info/bloc/profile_info_bloc.dart';
import 'package:uber_clone/src/presentation/screens/profile/info/bloc/profile_info_state.dart';
import 'package:uber_clone/src/presentation/utils/colors.dart';

class ProfileCard extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(16),
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
                        color: AppColors.backgroundDark,
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
                            color: AppColors.backgroundDark,
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
                            color: AppColors.backgroundDark,
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
    );
  }
}