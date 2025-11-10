import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart';

class BlocSocketIOState extends Equatable {

  final Socket? socket;
  final bool isConnected;

  const BlocSocketIOState({
    this.socket,
    this.isConnected = false
  });

  BlocSocketIOState copyWith({
    Socket? socket,
    bool? isConnected,
  }) {
    return BlocSocketIOState(
      socket: socket ?? this.socket,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  List<Object?> get props => [socket, isConnected];

}