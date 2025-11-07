import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    return const Scaffold(body: Center(child: Text('NOSE')));
  }
}
