import 'package:flutter/material.dart';
import 'package:uber_clone/src/presentation/utils/colors.dart';
import 'package:uber_clone/src/presentation/widgets/default_image_url.dart';

class UserCard extends StatelessWidget {
  final String? name;
  final String? lastname;
  final String? phone;
  final String? imageUrl;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  const UserCard({
    super.key,
    this.name,
    this.lastname,
    this.phone,
    this.imageUrl,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.greyLight,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            // Foto de perfil con DefaultImageUrl
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor ?? AppColors.backgroundDark,
                  width: 2,
                ),
              ),
              child: DefaultImageUrl(
                url: imageUrl,
                width: 60, // o puedes dejarlo por defecto si no necesitas cambiarlo
              ),
            ),
            const SizedBox(width: 16),

            // Nombre y teléfono
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getFullName(),
                    style: TextStyle(
                      color: textColor ?? AppColors.backgroundDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (phone != null && phone!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      phone!,
                      style: TextStyle(
                        color: (textColor ?? AppColors.backgroundDark).withValues(alpha: .7),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFullName() {
    if (name == null && lastname == null) {
      return 'Usuario';
    }
    
    final fullName = '${name ?? ''} ${lastname ?? ''}'.trim();
    return fullName.isNotEmpty ? fullName : 'Usuario';
  }
}