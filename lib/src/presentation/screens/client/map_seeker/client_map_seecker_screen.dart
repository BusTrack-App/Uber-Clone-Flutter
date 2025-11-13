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
  
  // Flag para controlar cuándo actualizar el texto del input
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
                mapType: MapType.normal,
                initialCameraPosition: state.cameraPosition,
                markers: Set<Marker>.of(state.markers.values),
                onCameraMove: (CameraPosition cameraPosition) {
                  context.read<ClientMapSeekerBloc>().add(
                    OnCameraMove(cameraPosition: cameraPosition),
                  );
                },
                onCameraIdle: () async {
                  // SOLUCIÓN: Solo actualizar si NO estamos seleccionando desde el autocompletado
                  if (!_isSelectingFromAutocomplete) {
                    context.read<ClientMapSeekerBloc>().add(OnCameraIdle());
                    
                    // Esperar a que el estado se actualice
                    await Future.delayed(const Duration(milliseconds: 100));
                    
                    // SOLUCIÓN: Actualizar SIEMPRE el texto cuando se mueve el mapa manualmente
                    if (state.placemarkData != null && state.placemarkData!.address.isNotEmpty) {
                      pickUpController.text = state.placemarkData!.address;
                      
                      // Actualizar el estado con la nueva dirección
                      // ignore: use_build_context_synchronously
                      context.read<ClientMapSeekerBloc>().add(OnAutoCompletedPickUpSelected(
                        lat: state.placemarkData!.lat, 
                        lng: state.placemarkData!.lng,
                        pickUpDescription: state.placemarkData!.address
                      ));
                    }
                  }
                  
                  // Reset el flag después de procesar
                  _isSelectingFromAutocomplete = false;
                },
                onMapCreated: (GoogleMapController controller) {
                  // Aplicar el estilo del mapa
                  controller.setMapStyle(MapStyles.darkMapStyle);
                  
                  if (state.controller != null) {
                    if (!state.controller!.isCompleted) {
                      state.controller?.complete(controller);
                    }
                  }
                },
              ),
              Container(
                height: 120,
                margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: _googlePlacesAutocomplete()
              ),
              _iconMyLocation(),
              Container(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  margin: const EdgeInsets.only(bottom: 30, left: 60, right: 60),
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
                      }
                    );
                  }
                )
              )
            ],
          );
        },
      ),
    );
  }

  Widget _googlePlacesAutocomplete() {
    return Card(
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          GooglePlacesAutoComplete(
            pickUpController, 
            'Recoger en', 
            (Prediction prediction) {
              // SOLUCIÓN: Activar el flag antes de cambiar la cámara
              _isSelectingFromAutocomplete = true;
              
              // Actualizar el texto del controller inmediatamente
              pickUpController.text = prediction.description ?? '';
              
              context.read<ClientMapSeekerBloc>().add(ChangeMapCameraPosition(
                lat: double.parse(prediction.lat!), 
                lng: double.parse(prediction.lng!),
              ));
              context.read<ClientMapSeekerBloc>().add(OnAutoCompletedPickUpSelected(
                lat: double.parse(prediction.lat!), 
                lng: double.parse(prediction.lng!),
                pickUpDescription: prediction.description ?? ''
              ));
            }
          ),
          Divider(
            color: Colors.grey[200],
          ),
          GooglePlacesAutoComplete(
            destinationController, 
            'Dejar en', 
            (Prediction prediction) {
              // Actualizar el texto del controller inmediatamente
              destinationController.text = prediction.description ?? '';
              
              context.read<ClientMapSeekerBloc>().add(OnAutoCompletedDestinationSelected(
                lat: double.parse(prediction.lat!), 
                lng: double.parse(prediction.lng!),
                destinationDescription: prediction.description ?? ''
              ));
            }
          )
        ],
      ),
    );
  }

  Widget _iconMyLocation() {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      alignment: Alignment.center,
      child: Image.asset('assets/img/location_blue.png', width: 50, height: 50),
    );
  }
}