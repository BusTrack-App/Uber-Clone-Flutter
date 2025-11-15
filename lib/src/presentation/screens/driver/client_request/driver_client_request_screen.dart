import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/bloc/driver_client_request_bloc.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/bloc/driver_client_request_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/bloc/driver_client_request_state.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/driver_client_request_item.dart';
import 'package:uber_clone/src/presentation/utils/colors.dart';

class DriverClientRequestScreen extends StatefulWidget {
  const DriverClientRequestScreen({super.key});

  @override
  State<DriverClientRequestScreen> createState() =>
      _DriverClientRequestScreenState();
}

class _DriverClientRequestScreenState extends State<DriverClientRequestScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DriverClientRequestsBloc>().add(InitDriverClientRequest());
      context
          .read<DriverClientRequestsBloc>()
          .add(ListenNewClientRequestSocketIO());
      // context.read<DriverClientRequestsBloc>().add(GetNearbyTripRequest());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<DriverClientRequestsBloc, DriverClientRequestsState>(
        listener: (context, state) {
          final responseCreateTripRequest =
              state.responseCreateDriverTripRequest;
          if (responseCreateTripRequest is Success) {
            Fluttertoast.showToast(
                msg: 'La oferta se ha enviado correctamente',
                toastLength: Toast.LENGTH_LONG);
          } else if (responseCreateTripRequest is ErrorData) {
            Fluttertoast.showToast(
                msg: responseCreateTripRequest.message,
                toastLength: Toast.LENGTH_LONG);
          }
        },
        child: BlocBuilder<DriverClientRequestsBloc, DriverClientRequestsState>(
            builder: (context, state) {
          final response = state.response;
          if (response is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (response is Success) {
            List<ClientRequestResponse> clientRequests =
                response.data as List<ClientRequestResponse>;
            debugPrint('Driver Request: $clientRequests');
            return ListView.builder(
                itemCount: clientRequests.length,
                itemBuilder: (context, index) {
                  return DriverClientRequestsItem(state, clientRequests[index]);
                });
          }
          return Center(child: Text('No hay solicitudes'),);
        }),
      ),
    );
  }
}
