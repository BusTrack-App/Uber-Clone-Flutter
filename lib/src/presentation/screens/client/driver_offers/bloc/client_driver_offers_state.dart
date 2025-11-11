import 'package:equatable/equatable.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

class ClientDriverOffersState extends Equatable {

  final Resource? responseDriverOffers;
  final Resource? responseAssignDriver;

  const ClientDriverOffersState({
    this.responseDriverOffers,
    this.responseAssignDriver
  });

  ClientDriverOffersState copyWith({
    Resource? responseDriverOffers,
    Resource? responseAssignDriver
  }) {
    return ClientDriverOffersState(
      responseDriverOffers: responseDriverOffers ?? this.responseDriverOffers,
      responseAssignDriver: responseAssignDriver
    );
  }

  @override
  List<Object?> get props => [responseDriverOffers, responseAssignDriver];

}