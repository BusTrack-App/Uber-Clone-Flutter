
abstract class ClientDriverOffersEvent {}

class GetDriverOffers extends ClientDriverOffersEvent {
  final int idClientRequest;

  GetDriverOffers({required this.idClientRequest});
}

class ListenNewDriverOfferSocketIO extends ClientDriverOffersEvent {
  final int idClientRequest;
  ListenNewDriverOfferSocketIO({required this.idClientRequest});
}

class AssignDriver extends ClientDriverOffersEvent {
  final int idClientRequest;
  final int idDriver;
  final double fareAssigned;
  AssignDriver({
    required this.idClientRequest,
    required this.idDriver,
    required this.fareAssigned,
  });
}
