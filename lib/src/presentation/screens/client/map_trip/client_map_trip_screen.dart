import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/client/map_trip/bloc/client_map_trip_bloc.dart';
import 'package:uber_clone/src/presentation/screens/client/map_trip/bloc/client_map_trip_event.dart';
import 'package:uber_clone/src/presentation/screens/client/map_trip/bloc/client_map_trip_state.dart';
import 'package:uber_clone/src/presentation/screens/client/map_trip/client_map_trip_content.dart';

class ClientMapTripScreen extends StatefulWidget {
  const ClientMapTripScreen({super.key});

  @override
  State<ClientMapTripScreen> createState() => _ClientMapTripScreenState();
}

class _ClientMapTripScreenState extends State<ClientMapTripScreen> {
  int? idClientRequest;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (idClientRequest != null) {
        context.read<ClientMapTripBloc>().add(
          GetClientRequest(idClientRequest: idClientRequest!),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    idClientRequest = ModalRoute.of(context)?.settings.arguments as int;
    debugPrint(idClientRequest.toString());
    return Scaffold(
      body: BlocListener<ClientMapTripBloc, ClientMapTripState>(
        listener: (context, state) {
          final responseClientRequest = state.responseGetClientRequest;

          if (responseClientRequest is Success) {
            final data = responseClientRequest.data as ClientRequestResponse;
            debugPrint('ClientRequestResponse: ${data.toJson()}');
          } else if (responseClientRequest is ErrorData) {
            Fluttertoast.showToast(
              msg: responseClientRequest.message,
              toastLength: Toast.LENGTH_LONG,
            );
          }
        },
        child: BlocBuilder<ClientMapTripBloc, ClientMapTripState>(
          builder: (context, state) {
            return ClientMapTripContent();
          },
        ),
      ),
    );
  }
}
