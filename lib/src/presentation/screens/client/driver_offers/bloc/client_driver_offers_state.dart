import 'package:equatable/equatable.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

class ClientDriverOffersState extends Equatable {
  final Resource? responseDriverOffers;
  // final Resource? responseAssignDriver;

  const ClientDriverOffersState({
    this.responseDriverOffers,
    // fthis.responseAssignDriver
  });

  ClientDriverOffersState copyWith({
    Resource? responseDriverOffers,
    // fResource? responseAssignDriver
  }) {
    return ClientDriverOffersState(
      responseDriverOffers: responseDriverOffers ?? this.responseDriverOffers,
      // fresponseAssignDriver: responseAssignDriver
    );
  }

  @override
  List<Object?> get props => [responseDriverOffers, 
  // fresponseAssignDriver
  ];
}
