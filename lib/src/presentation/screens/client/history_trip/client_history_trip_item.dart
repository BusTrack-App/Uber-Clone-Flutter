import 'package:flutter/material.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/presentation/utils/colors.dart';
import 'package:uber_clone/src/presentation/widgets/default_image_url.dart';

class ClientHistoryTripItem extends StatelessWidget {
  final ClientRequestResponse clientRequest;

  const ClientHistoryTripItem(this.clientRequest, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.greyLight, width: 1),
      ),
      child: Column(
        children: [
          // Header - Conductor (equivalente al UserCard)
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildDriverHeader(),
          ),

          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1, color: AppColors.greyLight),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Locations
                _buildLocationRow(
                  Icons.location_on,
                  AppColors.red,
                  'Desde',
                  clientRequest.pickupDescription,
                ),
                const SizedBox(height: 16),
                _buildLocationRow(
                  Icons.flag,
                  AppColors.greyLight,
                  'Hasta',
                  clientRequest.destinationDescription,
                ),

                const SizedBox(height: 20),

                // Tarifa y Duración
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoBox(
                        Icons.attach_money,
                        'Tarifa pagada',
                        '\$${clientRequest.fareAssigned ?? '0'}',
                        AppColors.yellow,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInfoBox(
                        Icons.access_time,
                        'Duración',
                        _calculateDuration(),
                        AppColors.greyMedium,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Fechas detalladas
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildDateRow(
                        Icons.play_circle_outline,
                        'Inicio',
                        _formatDate(clientRequest.createdAt?.toString()),
                      ),
                      const SizedBox(height: 10),
                      _buildDateRow(
                        Icons.check_circle_outline,
                        'Fin',
                        _formatDate(clientRequest.updatedAt.toString()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // === WIDGETS AUXILIARES (mismos que en DriverHistoryTripItem) ===

  Widget _buildDriverHeader() {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.greyLight.withValues(alpha: .3),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: DefaultImageUrl(
              url: clientRequest.driver?.image,
              width: 56,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Conductor',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.greyMedium,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '${clientRequest.driver?.name ?? 'N/A'} ${clientRequest.driver?.lastname ?? ''}'.trim(),
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.backgroundDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationRow(
    IconData icon,
    Color color,
    String label,
    String text,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.greyMedium,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.backgroundDark,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBox(IconData icon, String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: .2), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.greyMedium,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color == AppColors.yellow
                  ? AppColors.yellowDark
                  : AppColors.backgroundDark,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDateRow(IconData icon, String label, String date) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.greyMedium),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.greyMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            date,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.backgroundDark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return 'N/A';

    try {
      final DateTime dateTime = DateTime.parse(date);
      final String day = dateTime.day.toString().padLeft(2, '0');
      final String month = dateTime.month.toString().padLeft(2, '0');
      final String year = dateTime.year.toString();
      final String hour = dateTime.hour.toString().padLeft(2, '0');
      final String minute = dateTime.minute.toString().padLeft(2, '0');

      return '$day/$month/$year $hour:$minute';
    } catch (e) {
      return date;
    }
  }

  String _calculateDuration() {
    if (clientRequest.createdAt == null) {
      return 'N/A';
    }

    try {
      final DateTime start = DateTime.parse(clientRequest.createdAt!.toString());
      final DateTime end = DateTime.parse(clientRequest.updatedAt.toString());
      final Duration duration = end.difference(start);

      if (duration.inHours > 0) {
        return '${duration.inHours}h ${duration.inMinutes % 60}m';
      } else if (duration.inMinutes > 0) {
        return '${duration.inMinutes}m';
      } else {
        return '${duration.inSeconds}s';
      }
    } catch (e) {
      return 'N/A';
    }
  }
}