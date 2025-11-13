import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/models/auth_response.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/client_requests_use_cases.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/screens/driver/history_trip/bloc/driver_history_trip_event.dart';
import 'package:uber_clone/src/presentation/screens/driver/history_trip/bloc/driver_history_trip_state.dart';


class DriverHistoryTripBloc extends Bloc<DriverHistoryTripEvent, DriverHistoryTripState> {

  AuthUseCases authUseCases;
  ClientRequestsUseCases clientRequestsUseCases;

  DriverHistoryTripBloc(this.clientRequestsUseCases, this.authUseCases): super(DriverHistoryTripState()) {
    on<GetHistoryTrip>((event, emit) async {
      emit(
        state.copyWith(
          response: Loading()
        )
      );
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      Resource response = await clientRequestsUseCases.getByDriverAssigned.run(authResponse.user.id!);
      emit(
        state.copyWith(
          response: response
        )
      );
    });
  }

}