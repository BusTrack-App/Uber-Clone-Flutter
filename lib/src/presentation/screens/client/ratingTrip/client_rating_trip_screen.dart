import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/client/ratingTrip/bloc/client_rating_trip_bloc.dart';
import 'package:uber_clone/src/presentation/screens/client/ratingTrip/bloc/client_rating_trip_state.dart';
import 'package:uber_clone/src/presentation/screens/client/ratingTrip/client_rating_trip_content.dart';


class ClientRatingTripScreen extends StatefulWidget {
  const ClientRatingTripScreen({super.key});

  @override
  State<ClientRatingTripScreen> createState() => _ClientRatingTripScreenState();
}

class _ClientRatingTripScreenState extends State<ClientRatingTripScreen> {
  ClientRequestResponse? clientRequestResponse;

  @override
  Widget build(BuildContext context) {
    clientRequestResponse = ModalRoute.of(context)?.settings.arguments as ClientRequestResponse;
    return Scaffold(
      body: BlocListener<ClientRatingTripBloc, ClientRatingTripState>(
        listener: (context, state) {
          final response = state.response;
          if (response is ErrorData) {
            Fluttertoast.showToast(msg: response.message, toastLength: Toast.LENGTH_LONG);
          }
          else if (response is Success) {
            Navigator.pushNamedAndRemoveUntil(context, 'client/home', (route) => false);
          }
        },
        child: BlocBuilder<ClientRatingTripBloc, ClientRatingTripState>(
          builder: (context, state) {
            return ClientRatingTripContent(state, clientRequestResponse);
          },
        ),
      ),
    );
  }
}