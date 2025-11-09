import 'package:uber_clone/src/domain/models/driver_trip_request.dart';
import 'package:uber_clone/src/presentation/utils/bloc_form_item.dart';

abstract class DriverClientRequestsEvent {}

class InitDriverClientRequest extends DriverClientRequestsEvent {}

class GetNearbyTripRequest extends DriverClientRequestsEvent {}


class CreateDriverTripRequest extends DriverClientRequestsEvent {
  final DriverTripRequest driverTripRequest;
  CreateDriverTripRequest({required this.driverTripRequest});
}

class FareOfferedChange extends DriverClientRequestsEvent {
  final BlocFormItem fareOffered;
  FareOfferedChange({required this.fareOffered});
}

// class ListenNewClientRequestSocketIO extends DriverClientRequestsEvent {}

// class EmitNewDriverOfferSocketIO extends DriverClientRequestsEvent{
//   final int idClientRequest;
//   EmitNewDriverOfferSocketIO({required this.idClientRequest});
// }
