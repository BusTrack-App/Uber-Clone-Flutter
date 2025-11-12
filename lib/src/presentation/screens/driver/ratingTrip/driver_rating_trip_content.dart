import 'package:flutter/material.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/presentation/screens/driver/ratingTrip/bloc/driver_rating_trip_state.dart';

class DriverRatingTripContent extends StatelessWidget {

  DriverRatingTripState driverRatingTripState;
  ClientRequestResponse? clientRequestResponse;

  DriverRatingTripContent(this.driverRatingTripState, this.clientRequestResponse, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Driver Rating Trip')));

  } 


}