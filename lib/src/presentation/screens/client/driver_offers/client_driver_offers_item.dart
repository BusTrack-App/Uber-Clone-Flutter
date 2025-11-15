import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/models/driver_trip_request.dart';
import 'package:uber_clone/src/presentation/screens/client/driver_offers/bloc/client_driver_offers_bloc.dart';
import 'package:uber_clone/src/presentation/screens/client/driver_offers/bloc/client_driver_offers_event.dart';
import 'package:uber_clone/src/presentation/utils/colors.dart';
import 'package:uber_clone/src/presentation/utils/user_card.dart';
import 'package:uber_clone/src/presentation/widgets/custom_button.dart';

class ClientDriverOffersItem extends StatelessWidget {
  final DriverTripRequest? driverTripRequest;

  const ClientDriverOffersItem(this.driverTripRequest, {super.key});

  @override
  Widget build(BuildContext context) {
    if (driverTripRequest == null) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // Información del conductor
          UserCard(
            name: driverTripRequest!.driver?.name,
            lastname: driverTripRequest!.driver?.lastname,
            imageUrl: driverTripRequest!.driver?.image,
            backgroundColor: AppColors.background,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 1,
              color: AppColors.greyMedium,
            ),
          ),
          UserCard(
            name: driverTripRequest!.car!.brand,
            phone:  '${driverTripRequest?.car?.plate} - ${driverTripRequest?.car?.color}',
            imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKGbrUhKoGOsCi_hR2c0IFNFMFJgx7_d87D5363c_uLITymI2NotuyRcsilcj4AflkVjA&usqp=CAU',
            backgroundColor: AppColors.background,
          ),

          // Detalles del viaje y botón
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Precio
                Text(
                  '\$${driverTripRequest!.fareOffered}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundDark,
                  ),
                ),

                // Tiempo y distancia
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${driverTripRequest!.time} min',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.yellowDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${driverTripRequest!.distance} km',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.yellowDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      driverTripRequest!.car?.brand ?? 'Auto',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.greyMedium,
                      ),
                    ),
                    CustomButton(
                      text: 'Aceptar',
                      onPressed: () {
                        context.read<ClientDriverOffersBloc>().add(
                              AssignDriver(
                                idClientRequest: driverTripRequest!.idClientRequest,
                                idDriver: driverTripRequest!.idDriver,
                                fareAssigned: driverTripRequest!.fareOffered,
                              ),
                            );
                      },
                      width: 140,
                      height: 44,
                      textColor: Colors.white,
                      margin: EdgeInsets.zero,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Botón Aceptar
        ],
      ),
    );
  }
}