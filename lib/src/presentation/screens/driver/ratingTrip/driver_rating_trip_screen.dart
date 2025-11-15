import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/src/domain/models/client_request_response.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/driver/ratingTrip/bloc/driver_rating_trip_bloc.dart';
import 'package:uber_clone/src/presentation/screens/driver/ratingTrip/bloc/driver_rating_trip_state.dart';
import 'package:uber_clone/src/presentation/screens/driver/ratingTrip/driver_rating_trip_content.dart';
import 'package:uber_clone/src/presentation/utils/colors.dart';


class DriverRatingTripScreen extends StatefulWidget {
  const DriverRatingTripScreen({super.key});

  @override
  State<DriverRatingTripScreen> createState() => _DriverRatingTripScreenState();
}

class _DriverRatingTripScreenState extends State<DriverRatingTripScreen> {
  ClientRequestResponse? clientRequestResponse;
  @override
  Widget build(BuildContext context) {
    clientRequestResponse =
        ModalRoute.of(context)?.settings.arguments as ClientRequestResponse;
    return Scaffold(
      body: BlocListener<DriverRatingTripBloc, DriverRatingTripState>(
        listener: (context, state) {
          final response = state.response;
          if (response is ErrorData) {
            Fluttertoast.showToast(msg: response.message, toastLength: Toast.LENGTH_LONG);
          }
          else if (response is Success) {
            Navigator.pushNamedAndRemoveUntil(context, 'driver/home', (route) => false);
          }
        },
        child: BlocBuilder<DriverRatingTripBloc, DriverRatingTripState>(
          builder: (context, state) {
            return Container(
                decoration: BoxDecoration(
                  color: AppColors.background
                ),
                child: DriverRatingTripContent(state, clientRequestResponse));
          },
        ),
      ),
    );
  }
}
