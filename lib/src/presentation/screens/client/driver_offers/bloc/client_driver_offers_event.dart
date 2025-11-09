
abstract class ClientDriverOffersEvent {}

class GetDriverOffers extends ClientDriverOffersEvent{
  final int idClientRequest;

  GetDriverOffers({required this.idClientRequest});
}

