import 'package:dartz/dartz.dart';
import 'package:restaurant/core/error/failure.dart';
import 'package:restaurant/core/service/remote/dio_consumer.dart';
import 'package:restaurant/features/restaurant/domain/entities/categories/categories_response.dart';
import 'package:restaurant/features/restaurant/domain/entities/map/map_response.dart';
import 'package:restaurant/features/restaurant/domain/entities/product/product_request.dart';
import 'package:restaurant/features/restaurant/domain/entities/product/product_response.dart';
part 'endpoints.dart';

abstract class BaseRestaurantDataSource {
  Future<Either<Failure, List<MapResponse>>> getRestaurants();
  Future<Either<Failure, List<CategoriesResponse>>> getCategories(int id);
  Future<Either<Failure, List<ProductResponse>>> getProducts(ProductsRequest productsRequest);
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

  @override
  Future<Either<Failure, List<ProductResponse>>> getProducts(ProductsRequest productsRequest) async {
    {
      final responseEither = await _dio.get(
        _RestaurantEndPoints.product(productsRequest.branchId,productsRequest.categoryId),
      );
      return responseEither.fold(
            (failure) => Left(failure),
            (response) {
          final productListJson = response["data"] as List<dynamic>;
          final  productList = productListJson
              .map(
                (productJson) => ProductResponse.fromJson(
                    productJson as Map<String, dynamic>),
          )
              .toList();
          return Right(productList);
        },
      );
    }
  }
}
