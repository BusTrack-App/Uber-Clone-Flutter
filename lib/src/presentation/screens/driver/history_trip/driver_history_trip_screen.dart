import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/driver/history_trip/bloc/driver_history_trip_bloc.dart';
import 'package:uber_clone/src/presentation/screens/driver/history_trip/bloc/driver_history_trip_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/history_trip/bloc/driver_history_trip_state.dart';
import 'package:uber_clone/src/presentation/screens/driver/history_trip/driver_history_trip_item.dart';


class DriverHistoryTripScreen extends StatefulWidget {
  const DriverHistoryTripScreen({super.key});

  @override
  State<DriverHistoryTripScreen> createState() => _DriverHistoryTripScreenState();
}

class _DriverHistoryTripScreenState extends State<DriverHistoryTripScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DriverHistoryTripBloc>().add(GetHistoryTrip());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverHistoryTripBloc, DriverHistoryTripState>(
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
                return DriverHistoryTripItem(data[index]);
              }
          );
        }
        return Container();
      },
    );
  }
}
