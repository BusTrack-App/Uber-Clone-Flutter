import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/client_requests_use_cases.dart';
import 'package:uber_clone/src/presentation/screens/client/ratingTrip/bloc/client_rating_trip_event.dart';
import 'package:uber_clone/src/presentation/screens/client/ratingTrip/bloc/client_rating_trip_state.dart';


class ClientRatingTripBloc extends Bloc<ClientRatingTripEvent, ClientRatingTripState> {
  ClientRequestsUseCases clientRequestsUseCases;
  ClientRatingTripBloc(this.clientRequestsUseCases): super(ClientRatingTripState()) {
    
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