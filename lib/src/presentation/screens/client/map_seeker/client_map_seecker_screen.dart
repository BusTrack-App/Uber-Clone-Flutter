import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/src/presentation/screens/client/map_seeker/bloc/client_map_seeker_bloc.dart.dart';
import 'package:uber_clone/src/presentation/screens/client/map_seeker/bloc/client_map_seeker_event.dart.dart';
import 'package:uber_clone/src/presentation/screens/client/map_seeker/bloc/client_map_seeker_state.dart';
import 'package:uber_clone/src/presentation/widgets/google_places_auto_complete.dart';

class ClientMapSeeckerScreen extends StatefulWidget {
  const ClientMapSeeckerScreen({super.key});

  @override
  State<ClientMapSeeckerScreen> createState() => ClientMapSeeckerScreenState();
}

class ClientMapSeeckerScreenState extends State<ClientMapSeeckerScreen> {
  TextEditingController pickUpController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClientMapSeekerBloc>().add(ClientMapSeekerInitEvent());
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
                initialCameraPosition: _kGooglePlex,
                markers: Set<Marker>.of(state.markers.values),
                onMapCreated: (GoogleMapController controller) {
                  // ignore: deprecated_member_use
                  controller.setMapStyle(
                    '[ { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 13 } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#144b53" }, { "lightness": 14 }, { "weight": 1.4 } ] }, { "featureType": "landscape", "elementType": "all", "stylers": [ { "color": "#08304b" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#0c4152" }, { "lightness": 5 } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b434f" }, { "lightness": 25 } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.arterial", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b3d51" }, { "lightness": 16 } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "color": "#146474" } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "color": "#021019" } ] } ]',
                  );
                  if (state.controller != null) {
                    if (!state.controller!.isCompleted) {
                      state.controller?.complete(controller);
                    }
                  }
                },
              ),
              Container(
                height: 120,
                margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Card(
                  surfaceTintColor: Colors.white,
                  child: Column(
                    children: [
                      GooglePlacesAutoComplete(pickUpController, 'Desde', (
                        prediction,
                      ) {
                        debugPrint('Lugar de recogida lat: ${prediction.lat}');
                        debugPrint('Lugar de recogida lng: ${prediction.lng}');
                      }),
                      const SizedBox(height: 15),
                      GooglePlacesAutoComplete(destinationController, 'Hasta', (
                        prediction,
                      ) {
                        debugPrint('Hasta de recogida lat: ${prediction.lat}');
                        debugPrint('Hasta de recogida lng: ${prediction.lng}');
                      }),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
