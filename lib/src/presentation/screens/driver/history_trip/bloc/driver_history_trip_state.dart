import 'package:equatable/equatable.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

class DriverHistoryTripState extends Equatable {

  final Resource? response;

  const DriverHistoryTripState({
    this.response
  });

   DriverHistoryTripState copyWith({
    Resource? response
   }) {
    return DriverHistoryTripState(response: response ?? this.response);
   }

   @override
  List<Object?> get props => [response];
}