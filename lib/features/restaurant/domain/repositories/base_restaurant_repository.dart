import 'package:dartz/dartz.dart';
import 'package:restaurant/core/error/failure.dart';
import 'package:restaurant/features/restaurant/domain/entities/categories/categories_response.dart';
import 'package:restaurant/features/restaurant/domain/entities/map/map_response.dart';

abstract class BaseRestaurantRepository {
  Future<Either<Failure,List<MapResponse>>> getRestaurants();
  Future<Either<Failure,List<CategoriesResponse>>> getCategories(int id);
}