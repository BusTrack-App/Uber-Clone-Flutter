import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:uber_clone/src/presentation/screens/client/map_seeker/bloc/client_map_seeker_bloc.dart.dart';
import 'package:uber_clone/src/presentation/screens/client/map_seeker/bloc/client_map_seeker_event.dart.dart';
import 'package:uber_clone/src/presentation/screens/client/map_seeker/bloc/client_map_seeker_state.dart';
import 'package:uber_clone/src/presentation/widgets/custom_button.dart';
import 'package:uber_clone/src/presentation/widgets/google_places_auto_complete.dart';
import 'package:uber_clone/src/presentation/utils/map_styles.dart'; // Importar map styles

class ClientMapSeeckerScreen extends StatefulWidget {
  const ClientMapSeeckerScreen({super.key});

  @override
  State<ClientMapSeeckerScreen> createState() => ClientMapSeeckerScreenState();
}

class ClientMapSeeckerScreenState extends State<ClientMapSeeckerScreen> {
  TextEditingController pickUpController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  
  bool _isSelectingFromAutocomplete = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClientMapSeekerBloc>().add(ClientMapSeekerInitEvent());
      context.read<ClientMapSeekerBloc>().add(ListenDriversPositionSocketIO());
      context.read<ClientMapSeekerBloc>().add(ListenDriversDisconnectedSocketIO());
      context.read<ClientMapSeekerBloc>().add(FindPosition());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ClientMapSeekerBloc, ClientMapSeekerState>(
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                style: MapStyles.darkMapStyle,
                mapType: MapType.normal,
                initialCameraPosition: state.cameraPosition,
                markers: Set<Marker>.of(state.markers.values),
                onCameraMove: (CameraPosition cameraPosition) {
                  context.read<ClientMapSeekerBloc>().add(
                    OnCameraMove(cameraPosition: cameraPosition),
                  );
                },
                onCameraIdle: () async {
                  if (!_isSelectingFromAutocomplete) {
                    context.read<ClientMapSeekerBloc>().add(OnCameraIdle());
                    await Future.delayed(const Duration(milliseconds: 100));
                    if (state.placemarkData != null && state.placemarkData!.address.isNotEmpty) {
                      pickUpController.text = state.placemarkData!.address;
                      // ignore: use_build_context_synchronously
                      context.read<ClientMapSeekerBloc>().add(OnAutoCompletedPickUpSelected(
                        lat: state.placemarkData!.lat, 
                        lng: state.placemarkData!.lng,
                        pickUpDescription: state.placemarkData!.address
                      ));
                    }
                  }
                  _isSelectingFromAutocomplete = false;
                },
                onMapCreated: (GoogleMapController controller) {
                  if (state.controller != null && !state.controller!.isCompleted) {
                    state.controller?.complete(controller);
                  }
                },
              ),

              // Icono de ubicación centrado (sin cambios)
              _iconMyLocation(),

              // Modal inferior con autocompletados y botón
              Align(
                alignment: Alignment.bottomCenter,
                child: _bottomCard(context, state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _bottomCard(BuildContext context, ClientMapSeekerState state) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      decoration: const BoxDecoration(
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
          const SizedBox(height: 12),
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),

          // Autocompletado de recogida
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GooglePlacesAutoComplete(
              pickUpController,
              'Recoger en',
              (Prediction prediction) {
                _isSelectingFromAutocomplete = true;
                pickUpController.text = prediction.description ?? '';
                context.read<ClientMapSeekerBloc>().add(ChangeMapCameraPosition(
                  lat: double.parse(prediction.lat!),
                  lng: double.parse(prediction.lng!),
                ));
                context.read<ClientMapSeekerBloc>().add(OnAutoCompletedPickUpSelected(
                  lat: double.parse(prediction.lat!),
                  lng: double.parse(prediction.lng!),
                  pickUpDescription: prediction.description ?? '',
                ));
              },
            ),
          ),

          const SizedBox(height: 12),

          // Autocompletado de destino
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GooglePlacesAutoComplete(
              destinationController,
              'Dejar en',
              (Prediction prediction) {
                destinationController.text = prediction.description ?? '';
                context.read<ClientMapSeekerBloc>().add(OnAutoCompletedDestinationSelected(
                  lat: double.parse(prediction.lat!),
                  lng: double.parse(prediction.lng!),
                  destinationDescription: prediction.description ?? '',
                ));
              },
            ),
          ),

          const Spacer(),

          // Botón Revisar Viaje
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, bottom: 30),
            child: CustomButton(
              text: 'REVISAR VIAJE',
              iconData: Icons.check_circle,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'client/map/booking',
                  arguments: {
                    'pickUpLatLng': state.pickUpLatLng,
                    'destinationLatLng': state.destinationLatLng,
                    'pickUpDescription': state.pickUpDescription,
                    'destinationDescription': state.destinationDescription,
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconMyLocation() {
    return Container(
      margin: const EdgeInsets.only(bottom: 55),
      alignment: Alignment.center,
      child: Image.asset('assets/img/location_blue.png', width: 50, height: 50),
    );
  }
}