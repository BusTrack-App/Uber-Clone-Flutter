import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_seeker/bloc/driver_map_location_bloc.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_seeker/bloc/driver_map_location_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_seeker/bloc/driver_map_location_state.dart';
import 'package:uber_clone/src/presentation/utils/map_styles.dart';
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
      body: BlocBuilder<DriverMapLocationBloc, DriverMapLocationState>( 
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                style: MapStyles.darkMapStyle,
                initialCameraPosition: state.cameraPosition,
                markers: Set<Marker>.of(state.markers.values),
                onMapCreated: (GoogleMapController controller) {
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
                  text: 'Detener Localizacion', 
                  onPressed: () {
                    context.read<BlocSocketIO>().add(DisconnectSocketIO());
                    context.read<DriverMapLocationBloc>().add(StopLocation());
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