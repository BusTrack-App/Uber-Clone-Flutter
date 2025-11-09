import 'package:equatable/equatable.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';

class DriverClientRequestsState extends Equatable {
  final Resource? response;
  final Resource? responseCreateDriverTripRequest;
  final BlocFormItem fareOffered;
  final int? idDriver;

  const DriverClientRequestsState({
    this.response,
    this.responseCreateDriverTripRequest,
    this.fareOffered = const BlocFormItem(error: 'Ingresa la tarifa'),
    this.idDriver
  });

  DriverClientRequestsState copyWith({
    Resource? response,
    Resource? responseCreateDriverTripRequest,
    BlocFormItem? fareOffered,
    int? idDriver
  }) {
    return DriverClientRequestsState(
      response: response ?? this.response,
      responseCreateDriverTripRequest: responseCreateDriverTripRequest ?? this.responseCreateDriverTripRequest,
      fareOffered: fareOffered ?? this.fareOffered,
      idDriver: idDriver ?? this.idDriver
    );
  }

  @override
  List<Object?> get props => [
    response,
    responseCreateDriverTripRequest,
    fareOffered,
    idDriver
  ];
}
