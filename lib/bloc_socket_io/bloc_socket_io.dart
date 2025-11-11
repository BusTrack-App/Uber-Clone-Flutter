import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io_event.dart';
import 'package:uber_clone/bloc_socket_io/bloc_socket_io_state.dart';
import 'package:uber_clone/main.dart';
import 'package:uber_clone/src/domain/models/auth_response.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/socket/socket_use_cases.dart';

class BlocSocketIO extends Bloc<BlocSocketIOEvent, BlocSocketIOState> {

  SocketUseCases socketUseCases;
  AuthUseCases authUseCases;

  BlocSocketIO(this.socketUseCases, this.authUseCases): super(BlocSocketIOState()) {

    on<ConnectSocketIO>((event, emit) {
      Socket socket = socketUseCases.connect.run();
      emit(
        state.copyWith(socket: socket)
      );
    });

    on<DisconnectSocketIO>((event, emit) {
      socketUseCases.disconnect.run();
      emit(
        state.copyWith(socket: null)
      );
    });


    on<ListenDriverAssignedSocketIO>((event, emit) async{
      if (state.socket != null) {
        AuthResponse authResponse = await authUseCases.getUserSession.run();
        state.socket?.on('driver_assigned/${authResponse.user.id}', (data) {
          debugPrint('DATA ListenDriverAssignedSocketIO: $data');
          navigatorKey.currentState?.pushNamed('driver/map/trip', arguments: data['id_client_request']);
        });
      }
    });

  }

}