import 'package:equatable/equatable.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

class ClientHistoryTripState extends Equatable {

  final Resource? response;

  const ClientHistoryTripState({
    this.response
  });

   ClientHistoryTripState copyWith({
    Resource? response
   }) {
    return ClientHistoryTripState(response: response ?? this.response);
   }

   @override
  List<Object?> get props => [response];
}