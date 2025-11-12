import 'package:equatable/equatable.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

class DriverRatingTripState extends Equatable {

  final double rating;
  final Resource? response;

  const DriverRatingTripState({
    this.rating = 0,
    this.response
  });

  DriverRatingTripState copyWith({
    double? rating,
    Resource? response
  }) {
    return DriverRatingTripState(
      rating: rating ?? this.rating,
      response: response
    );
  }

  @override
  List<Object?> get props => [rating, response];

}