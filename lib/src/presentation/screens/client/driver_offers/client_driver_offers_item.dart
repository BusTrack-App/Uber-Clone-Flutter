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

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.greyMedium, width: 1),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // Información del conductor
          // UserCard(
          //   name: driverTripRequest!.driver?.name,
          //   lastname: driverTripRequest!.driver?.lastname,
          //   imageUrl: driverTripRequest!.driver?.image,
          //   backgroundColor: AppColors.backgroundLight,
          // ),
          UserCard(
            name: driverTripRequest!.car!.brand,
            phone:  '${driverTripRequest?.car?.plate} - ${driverTripRequest?.car?.color}',
            imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKGbrUhKoGOsCi_hR2c0IFNFMFJgx7_d87D5363c_uLITymI2NotuyRcsilcj4AflkVjA&usqp=CAU',
            backgroundColor: AppColors.backgroundLight,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 1,
              color: AppColors.greyMedium,
            ),
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
                    CustomButton(
                      text: 'Accept',
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