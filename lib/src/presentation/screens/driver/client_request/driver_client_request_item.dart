import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/domain/models/driver_trip_request.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/bloc/driver_client_request_bloc.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/bloc/driver_client_request_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/bloc/driver_client_request_state.dart';
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';
import 'package:uber_clone/src/presentation/widgets/custom_text_field.dart';
import 'package:uber_clone/src/data/api/api_config.dart';
import 'package:uber_clone/src/presentation/widgets/default_image_url.dart';

class AppColors {
  static const Color yellow = Color(0xFFF0C836);
  static const Color yellowLight = Color(0xFFFFF8C2);
  static const Color yellowDark = Color(0xFFCD8501);
  static const Color background = Color(0xFFF1F1F1);
  static const Color backgroundLight = Color(0xFFFDFDFD);
  static const Color backgroundDark = Color.fromARGB(255, 64, 62, 62);
  static const Color red = Color(0xFFF1331B);
  static const Color greyMedium = Color(0xFFC0C3C5);
  static const Color greyLight = Color.fromARGB(255, 225, 226, 226);
}

class DriverClientRequestsItem extends StatelessWidget {
  DriverClientRequestsState state;
  ClientRequestResponse? clientRequest;

  DriverClientRequestsItem(this.state, this.clientRequest, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FareOfferedDialog(context, () {
          if (clientRequest != null &&
              state.idDriver != null &&
              context
                  .read<DriverClientRequestsBloc>()
                  .state
                  .fareOffered
                  .value
                  .isNotEmpty) {
            context.read<DriverClientRequestsBloc>().add(
              CreateDriverTripRequest(
                driverTripRequest: DriverTripRequest(
                  idDriver: state.idDriver!,
                  idClientRequest: clientRequest!.id,
                  fareOffered: double.parse(
                    context
                        .read<DriverClientRequestsBloc>()
                        .state
                        .fareOffered
                        .value,
                  ),
                  time:
                      clientRequest!.googleDistanceMatrix!.duration.value
                          .toDouble() /
                      60,
                  distance:
                      clientRequest!.googleDistanceMatrix!.distance.value
                          .toDouble() /
                      1000,
                ),
              ),
            );
          } else {
            Fluttertoast.showToast(
              msg: 'No se puede enviar la oferta',
              toastLength: Toast.LENGTH_LONG,
            );
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.greyMedium, width: 1),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Row(
                children: [
                  _imageUser(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${clientRequest?.client.name ?? ''} ${clientRequest?.client.lastname ?? ''}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.backgroundDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.attach_money,
                              size: 16,
                              color: AppColors.yellow,
                            ),
                            Text(
                              clientRequest?.fareOffered ?? '0',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.yellow,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.backgroundDark,
                  ),
                ],
              ),
            ),

            // Body
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Locations
                  _buildLocationRow(
                    Icons.my_location,
                    AppColors.yellowDark,
                    clientRequest?.pickupDescription ?? '',
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(height: 1, color: AppColors.greyMedium),
                  ),
                  _buildLocationRow(
                    Icons.location_on,
                    AppColors.greyMedium,
                    clientRequest?.destinationDescription ?? '',
                  ),

                  const SizedBox(height: 16),
                  Container(height: 1, color: AppColors.greyLight),
                  const SizedBox(height: 16),

                  // Metrics
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetric(
                          Icons.access_time_outlined,
                          clientRequest?.googleDistanceMatrix?.duration.text ??
                              '',
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        color: AppColors.greyLight,
                      ),
                      Expanded(
                        child: _buildMetric(
                          Icons.route_outlined,
                          clientRequest?.googleDistanceMatrix?.distance.text ??
                              '',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationRow(IconData icon, Color color, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.backgroundDark,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetric(IconData icon, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: AppColors.greyMedium),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.backgroundDark,
          ),
        ),
      ],
    );
  }

  Widget _imageUser() {
    final imageUrl =
        clientRequest?.client.image != null &&
            clientRequest!.client.image!.isNotEmpty
        ? clientRequest!.client.image!
        : null;
    debugPrint('imageUrl');
    debugPrint(imageUrl);

    return DefaultImageUrl(url: imageUrl, width: 52);
  }

  // ignore: non_constant_identifier_names
  FareOfferedDialog(BuildContext context, Function() submit) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.attach_money,
                  color: AppColors.yellowDark,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Ingresa tu tarifa',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.backgroundDark,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                text: 'Valor',
                icon: Icons.attach_money,
                keyboardType: TextInputType.phone,
                onChanged: (text) {
                  debugPrint('Tarifa del viaje: $text');
                  context.read<DriverClientRequestsBloc>().add(
                    FareOfferedChange(fareOffered: BlocFormItem(value: text)),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          color: AppColors.greyMedium,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        submit();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: AppColors.yellow,
                        foregroundColor: AppColors.backgroundDark,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Enviar',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
