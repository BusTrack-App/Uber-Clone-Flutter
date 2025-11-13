import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/client/history_trip/bloc/client_history_trip_bloc.dart';
import 'package:uber_clone/src/presentation/screens/client/history_trip/bloc/client_history_trip_event.dart';
import 'package:uber_clone/src/presentation/screens/client/history_trip/bloc/client_history_trip_state.dart';
import 'package:uber_clone/src/presentation/screens/client/history_trip/client_history_trip_item.dart';


class ClientHistoryTripScreen extends StatefulWidget {
  const ClientHistoryTripScreen({super.key});

  @override
  State<ClientHistoryTripScreen> createState() => _ClientHistoryTripScreenState();
}

class _ClientHistoryTripScreenState extends State<ClientHistoryTripScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClientHistoryTripBloc>().add(GetHistoryTrip());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientHistoryTripBloc, ClientHistoryTripState>(
      builder: (context, state) {
        final response = state.response;
        if (response is Loading) {
          return Center(child: CircularProgressIndicator());
        }
        else if (response is Success) {
          List<ClientRequestResponse> data = response.data as List<ClientRequestResponse>;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ClientHistoryTripItem(data[index]);
              }
          );
        }
        return Container();
      },
    );
  }
}
