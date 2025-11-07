import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/src/presentation/screens/client/map_booking_info/bloc/client_map_booking_info_bloc.dart';
import 'package:uber_clone/src/presentation/screens/client/map_booking_info/bloc/client_map_booking_info_event.dart';
import 'package:uber_clone/src/presentation/screens/client/map_booking_info/bloc/client_map_booking_info_state.dart';
import 'package:uber_clone/src/presentation/screens/client/map_booking_info/client_map_booking_info_content.dart';

class ClientMapBookingInfoScreen extends StatefulWidget {
  const ClientMapBookingInfoScreen({super.key});

  @override
  State<ClientMapBookingInfoScreen> createState() =>
      _ClientMapBookingInfoScreenState();
}

class _ClientMapBookingInfoScreenState
    extends State<ClientMapBookingInfoScreen> {
  LatLng? pickUpLatLng;
  LatLng? destinationLatLng;
  String? pickUpDestination;
  String? destinationDescription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClientMapBookingInfoBloc>().add(
        ClientMapBookingInfoInitEvent(
          // pickUpLatLng: pickUpLatLng,
          // destinationLatLng: destinationLatLng,
          // pickUpDescription: pickUpDescription,
          // destinationDescription: destinationDescription,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    pickUpLatLng = arguments['pickUpLatLng'];
    destinationLatLng = arguments['destinationLatLng'];
    pickUpDestination = arguments['pickUpDescription'];
    destinationDescription = arguments['destinationDescription'];
    debugPrint('pickUpLatLng: ${pickUpLatLng?.toJson()}');
    debugPrint('destinationLatLng: ${destinationLatLng?.toJson()}');
    debugPrint('pickUpDestination: $pickUpDestination');
    debugPrint('destinationDescription: $destinationDescription');
    return Scaffold(
      body: BlocBuilder<ClientMapBookingInfoBloc, ClientMapBookingInfoState>(
        builder: (context, state) {
          return ClientMapBookingInfoContent(state);
        },
      ),
    );
  }
}
