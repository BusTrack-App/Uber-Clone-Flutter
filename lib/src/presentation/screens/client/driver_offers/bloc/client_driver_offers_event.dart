
abstract class ClientDriverOffersEvent {}

class GetDriverOffers extends ClientDriverOffersEvent{
  final int idClientRequest;

  GetDriverOffers({required this.idClientRequest});
}


class ListenNewDriverOfferSocketIO extends ClientDriverOffersEvent {
  final int idClientRequest;
  ListenNewDriverOfferSocketIO({required this.idClientRequest});
}
