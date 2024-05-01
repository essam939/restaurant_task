import 'package:dartz/dartz.dart';
import 'package:restaurant/core/error/failure.dart';
import 'package:restaurant/features/restaurant/domain/entities/map_response.dart';

abstract class BaseRestaurantRepository {
  Future<Either<Failure,List<MapResponse>>> getRestaurants();
}