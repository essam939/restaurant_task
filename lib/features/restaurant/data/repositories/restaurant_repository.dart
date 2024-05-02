import 'package:dartz/dartz.dart';
import 'package:restaurant/core/error/failure.dart';
import 'package:restaurant/features/restaurant/data/data_sources/restaurant_remote_data_source.dart';
import 'package:restaurant/features/restaurant/domain/entities/categories/categories_response.dart';
import 'package:restaurant/features/restaurant/domain/entities/map/map_response.dart';
import 'package:restaurant/features/restaurant/domain/entities/product/product_request.dart';
import 'package:restaurant/features/restaurant/domain/entities/product/product_response.dart';
import 'package:restaurant/features/restaurant/domain/repositories/base_restaurant_repository.dart';

class RestaurantRepository extends BaseRestaurantRepository {
  final BaseRestaurantDataSource baseRestaurantDataSource;

  RestaurantRepository({required this.baseRestaurantDataSource});

  @override
  Future<Either<Failure, List<MapResponse>>> getRestaurants() async {
    return await baseRestaurantDataSource.getRestaurants();
  }

  @override
  Future<Either<Failure, List<CategoriesResponse>>> getCategories(
      int id) async {
    return await baseRestaurantDataSource.getCategories(id);
  }

  @override
  Future<Either<Failure, List<ProductResponse>>> getProducts(ProductsRequest productsRequest) async {
    return await baseRestaurantDataSource.getProducts(productsRequest);
  }
}
