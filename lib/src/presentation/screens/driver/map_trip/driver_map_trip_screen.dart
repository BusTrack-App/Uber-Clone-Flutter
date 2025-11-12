import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_trip/bloc/driver_map_trip_bloc.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_trip/bloc/driver_map_trip_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_trip/bloc/driver_map_trip_state.dart';
import 'package:uber_clone/src/presentation/screens/driver/map_trip/driver_map_trip_content.dart';

class DriverMapTripScreen extends StatefulWidget {
  const DriverMapTripScreen({super.key});

  @override
  State<DriverMapTripScreen> createState() => _DriverMapTripScreenState();
}

class _DriverMapTripScreenState extends State<DriverMapTripScreen> {
  int? idClientRequest;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (idClientRequest != null) {
        context.read<DriverMapTripBloc>().add(InitDriverMapTripEvent());
        context.read<DriverMapTripBloc>().add(
          GetClientRequest(idClientRequest: idClientRequest!),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    idClientRequest = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      body: BlocListener<DriverMapTripBloc, DriverMapTripState>(
        listener: (context, state) {
          final responseClientRequest = state.responseGetClientRequest;
          if (responseClientRequest is Success) {
            final data = responseClientRequest.data as ClientRequestResponse;
            debugPrint('${data.toJson()}');
          } else if (responseClientRequest is ErrorData) {
            Fluttertoast.showToast(
              msg: responseClientRequest.message,
              toastLength: Toast.LENGTH_LONG,
            );
          }
        },
        child: BlocBuilder<DriverMapTripBloc, DriverMapTripState>(
          builder: (context, state) {
            final responseClientRequest = state.responseGetClientRequest;
            if (responseClientRequest is Success) {
              final data = responseClientRequest.data as ClientRequestResponse;
              return DriverMapTripContent(state, data, null);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
