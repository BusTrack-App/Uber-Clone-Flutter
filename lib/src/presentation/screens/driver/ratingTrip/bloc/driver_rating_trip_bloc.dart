import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/client_requests_use_cases.dart';
import 'package:uber_clone/src/presentation/screens/driver/ratingTrip/bloc/driver_rating_trip_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/ratingTrip/bloc/driver_rating_trip_state.dart';


class DriverRatingTripBloc extends Bloc<DriverRatingTripEvent, DriverRatingTripState> {
  ClientRequestsUseCases clientRequestsUseCases;
  DriverRatingTripBloc(this.clientRequestsUseCases): super(DriverRatingTripState()) {
    
    on<RatingChanged>((event, emit) {
      emit(
        state.copyWith(
          rating: event.rating
        )
      );  
    });

    on<UpdateRating>((event, emit) async {
    });
  }
}