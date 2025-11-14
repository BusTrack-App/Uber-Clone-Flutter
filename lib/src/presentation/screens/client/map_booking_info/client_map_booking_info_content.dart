import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/src/domain/models/time_and_distance_values.dart';
import 'package:uber_clone/src/presentation/screens/client/map_booking_info/bloc/client_map_booking_info_bloc.dart';
import 'package:uber_clone/src/presentation/screens/client/map_booking_info/bloc/client_map_booking_info_event.dart';
import 'package:uber_clone/src/presentation/screens/client/map_booking_info/bloc/client_map_booking_info_state.dart';
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';
import 'package:uber_clone/src/presentation/utils/colors.dart';
import 'package:uber_clone/src/presentation/utils/map_styles.dart';
import 'package:uber_clone/src/presentation/widgets/custom_button.dart';
import 'package:uber_clone/src/presentation/widgets/custom_text_field.dart';
import 'package:uber_clone/src/presentation/widgets/default_icon_back.dart';

class ClientMapBookingInfoContent extends StatelessWidget {
  final ClientMapBookingInfoState state;
  TimeAndDistanceValues timeAndDistanceValues;

  ClientMapBookingInfoContent(
    this.state,
    this.timeAndDistanceValues, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _googleMaps(context),
        Align(
          alignment: Alignment.bottomCenter,
          child: _cardBookingInfo(context),
        ),
        Container(
          margin: EdgeInsets.only(top: 50, left: 20),
          child: DefaultIconBack(),
        ),
      ],
    );
  }

  Widget _cardBookingInfo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.49,
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 186, 186, 186),
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          _item('Recoger en', state.pickUpDescription, Icons.location_on),
          _item('Dejar en', state.destinationDescription, Icons.my_location),
          _item('Tiempo y distancia aproximados', '${timeAndDistanceValues.distance.text} y ${timeAndDistanceValues.duration.text}', Icons.timer),
          _item('Precios recomendados', '\$${timeAndDistanceValues.recommendedValue}', Icons.money),
          CustomTextField(
            margin: EdgeInsets.only(left: 15, right: 15),
            text: 'OFRECE TU TARIFA',
            icon: Icons.attach_money,
            keyboardType: TextInputType.phone,
            onChanged: (text) {
              context.read<ClientMapBookingInfoBloc>().add(
                FareOfferedChanged(fareOffered: BlocFormItem(value: text)),
              );
            },
            validator: (value) {
              return state.fareOffered.error;
            },
          ),
          const SizedBox(height: 40),
          CustomButton(
            text: 'BUSCAR CONDUCTOR',
            onPressed: () {
              // Obtenemos el valor actual del campo desde el estado del BLoC
              final fareOffered = state.fareOffered.value;

              if ( fareOffered.trim().isEmpty) {
                Fluttertoast.showToast(
                  msg: 'El valor de la tarifa es necesario',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: AppColors.red,
                  textColor: AppColors.background,
                );
                return; // ¡Importante! Salimos sin hacer nada
              }

              // Si pasa la validación, enviamos el evento
              context.read<ClientMapBookingInfoBloc>().add(CreateClientRequest());
            },
            iconData: Icons.search,
          ),
        ],
      ),
    );
  }

  Widget _item(String title, String subtitle, IconData icon) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 15)),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 13),
      ),
      leading: Icon(icon),
    );
  }

  Widget _googleMaps(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.53,
      child: GoogleMap(
        mapType: MapType.normal,
        style: MapStyles.darkMapStyle,
        initialCameraPosition: state.cameraPosition,
        markers: Set<Marker>.of(state.markers.values),
        polylines: Set<Polyline>.of(state.polylines.values),
        onMapCreated: (GoogleMapController controller) {
          if (!state.controller!.isCompleted) {
            state.controller?.complete(controller);
          }
        },
      ),
    );
  }
}
