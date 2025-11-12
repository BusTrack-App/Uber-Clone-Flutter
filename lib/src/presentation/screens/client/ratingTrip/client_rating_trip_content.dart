import 'package:flutter/material.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/presentation/screens/client/ratingTrip/bloc/client_rating_trip_state.dart';

class ClientRatingTripContent extends StatelessWidget {
  ClientRatingTripState state;
  ClientRequestResponse? clientRequestResponse;

  ClientRatingTripContent(this.state, this.clientRequestResponse, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Client Rating Trip')));
  }
}
