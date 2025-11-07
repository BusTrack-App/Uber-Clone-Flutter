import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_seeker/bloc/driver_map_location_bloc.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_seeker/bloc/driver_map_location_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_seeker/bloc/driver_map_location_state.dart';
import 'package:uber_clone/src/presentation/widgets/custom_button.dart';

class DriverMapLocationScreen extends StatefulWidget {
  const DriverMapLocationScreen({super.key});

  @override
  State<DriverMapLocationScreen> createState() => DriverMapLocationScreenState();
}

class DriverMapLocationScreenState extends State<DriverMapLocationScreen> {
  TextEditingController pickUpController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DriverMapLocationBloc>().add(DriverMapLocationInitEvent());
      context.read<DriverMapLocationBloc>().add(FindPosition());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DriverMapLocationBloc, DriverMapLocationState>( // ¡CORREGIDO!
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: state.cameraPosition,
                markers: Set<Marker>.of(state.markers.values),
                onCameraMove: (CameraPosition cameraPosition) {
                  context.read<DriverMapLocationBloc>().add(
                    OnCameraMove(cameraPosition: cameraPosition),
                  );
                },
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
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  margin: EdgeInsets.only(bottom: 30, left: 60, right: 60),
                  text: 'Ver Viajes', 
                  iconData: Icons.check_circle,
                  // textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(
                      context, 
                      'client/map/booking',
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

}