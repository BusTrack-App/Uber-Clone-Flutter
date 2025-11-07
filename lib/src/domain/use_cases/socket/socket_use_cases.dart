import 'package:uber_clone/src/domain/use_cases/socket/connect_socket_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/socket/disconnect_socket_use_case.dart';

class SocketUseCases {

  ConnectSocketUseCase connect;
  DisconnectSocketUseCase disconnect;

  SocketUseCases({
    required this.connect,
    required this.disconnect
  });

}