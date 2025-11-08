import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/bloc/driver_client_request_bloc.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/bloc/driver_client_request_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/client_request/bloc/driver_client_request_state.dart';

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
      context.read<DriverClientRequestsBloc>().add(GetNearbyTripRequest());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<DriverClientRequestsBloc, DriverClientRequestsState>(
        listener: (context, state) {},
        child: BlocBuilder<DriverClientRequestsBloc, DriverClientRequestsState>(
          builder: (context, state) {
            final response = state.response;
            if (response is Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (response is Success) {
              List<ClientRequestResponse> clientRequests =
                  response.data as List<ClientRequestResponse>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Text(clientRequests[index].pickupDescription);
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
