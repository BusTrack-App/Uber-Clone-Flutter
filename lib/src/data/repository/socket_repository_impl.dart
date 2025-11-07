import 'package:socket_io_client/socket_io_client.dart';
import 'package:uber_clone/src/domain/repository/socket_repository.dart';

class SocketRepositoryImpl implements SocketRepository {

  Socket socket;

  SocketRepositoryImpl(this.socket);

  @override
  Socket connect() {
    return socket.connect();
  }

  @override
  Socket disconnect() {
    return socket.disconnect();
  }

}