import 'package:dartz/dartz.dart';
import 'package:restaurant/core/error/failure.dart';
import 'package:restaurant/core/service/remote/dio_consumer.dart';
import 'package:restaurant/features/restaurant/domain/entities/categories/categories_response.dart';
import 'package:restaurant/features/restaurant/domain/entities/map/map_response.dart';
part 'endpoints.dart';

abstract class BaseRestaurantDataSource {
  Future<Either<Failure, List<MapResponse>>> getRestaurants();
  Future<Either<Failure, List<CategoriesResponse>>> getCategories(int id);
}

class RestaurantDataSource extends BaseRestaurantDataSource {
  final DioConsumer _dio;

  RestaurantDataSource(this._dio);

  @override
  Future<Either<Failure, List<MapResponse>>> getRestaurants() async {
    {
      final responseEither = await _dio.get(
        _RestaurantEndPoints.getRestaurants,
      );
      return responseEither.fold(
        (failure) => Left(failure),
        (response) {
          final restaurantListJson = response["data"] as List<dynamic>;
          final restaurantList = restaurantListJson
              .map(
                (restaurantJson) => MapResponse.fromJson(
                    restaurantJson as Map<String, dynamic>),
              )
              .toList();
          return Right(restaurantList);
        },
      );
    }
  }

  @override
  Future<Either<Failure, List<CategoriesResponse>>> getCategories(int id) async {
    {
      final responseEither = await _dio.get(
        _RestaurantEndPoints.category(id),
      );
      return responseEither.fold(
        (failure) => Left(failure),
        (response) {
          final categoriesListJson = response["data"] as List<dynamic>;
          final categoriesList = categoriesListJson
              .map(
                (categoriesJson) => CategoriesResponse.fromJson(
                    categoriesJson as Map<String, dynamic>),
              )
              .toList();
          return Right(categoriesList);
        },
      );
    }
  }
}
