import 'package:equatable/equatable.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

class DriverClientRequestsState extends Equatable {
  final Resource? response;
  // final Resource? responseCreateDriverTripRequest;
  // final Resource? responseDriverPosition;
  // final BlocFormItem fareOffered;
  // final int? idDriver;

  const DriverClientRequestsState({
    this.response,
    // this.responseCreateDriverTripRequest,
    // this.responseDriverPosition,
    // this.fareOffered = const BlocFormItem(error: 'Ingresa la tarifa'),
    // this.idDriver
  });

  DriverClientRequestsState copyWith({
    Resource? response,
    // Resource? responseCreateDriverTripRequest,
    // Resource? responseDriverPosition,
    // BlocFormItem? fareOffered,
    // int? idDriver
  }) {
    return DriverClientRequestsState(
      response: response ?? this.response,
      // responseDriverPosition: responseDriverPosition ?? this.responseDriverPosition,
      // responseCreateDriverTripRequest: responseCreateDriverTripRequest,
      // fareOffered: fareOffered ?? this.fareOffered,
      // idDriver: idDriver ?? this.idDriver
    );
  }

  @override
  List<Object?> get props => [
    response,
    // responseCreateDriverTripRequest,
    // responseDriverPosition,
    // fareOffered,
    // idDriver,
  ];
}
