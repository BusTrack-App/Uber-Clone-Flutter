import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/models/driver_trip_request.dart';
import 'package:uber_clone/src/presentation/screens/client/driver_offers/bloc/client_driver_offers_bloc.dart';
import 'package:uber_clone/src/presentation/screens/client/driver_offers/bloc/client_driver_offers_event.dart';
import 'package:uber_clone/src/presentation/widgets/custom_button.dart';

class ClientDriverOffersItem extends StatelessWidget {

  DriverTripRequest? driverTripRequest;

  ClientDriverOffersItem(this.driverTripRequest, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: _imageUser(),
            title: Text(
              '${driverTripRequest?.driver?.name ?? ''} ${driverTripRequest?.driver?.lastname ?? ''}'
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(driverTripRequest?.car?.brand ?? ''),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${driverTripRequest?.time} min',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueAccent
                  ),
                ),
                Text(
                  '${driverTripRequest?.distance} km',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueAccent
                  )
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, bottom: 15),
                child: Text(
                  '\$${driverTripRequest?.fareOffered}',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold
                  ),
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
                    )
                  );
                },
                width: 120,
                height: 40,
                margin: EdgeInsets.only(right: 20, bottom: 15),
                color: Colors.blueAccent,
                textColor: Colors.white,
              )
            ],
          )
          
        ],
      ),
    );
  }

Widget _imageUser() {
  // Validar si la URL es válida
  bool isValidUrl(String? url) {
    if (url == null || url.isEmpty || url == 'null') {
      return false;
    }
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Obtener la URL de la imagen del driver
  final imageUrl = driverTripRequest?.driver?.image;
  final hasValidUrl = isValidUrl(imageUrl);

  return SizedBox(
    width: 60,
    child: AspectRatio(
      aspectRatio: 1,
      child: ClipOval(
        child: driverTripRequest != null
            ? hasValidUrl
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/img/user_image.png',
                    image: imageUrl!,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(seconds: 1),
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
  );
}
}