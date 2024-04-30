import 'package:dartz/dartz.dart';
import 'package:restaurant/core/error/failure.dart';
import 'package:restaurant/features/restaurant/data/data_sources/restaurant_remote_data_source.dart';
import 'package:restaurant/features/restaurant/domain/entities/map_response.dart';
import 'package:restaurant/features/restaurant/domain/repositories/base_restaurant_repository.dart';

class RestaurantRepository extends BaseRestaurantRepository {
  final BaseRestaurantDataSource baseRestaurantDataSource;

  RestaurantRepository({required this.baseRestaurantDataSource});

  @override
  Future<Either<Failure, MapResponse>> getRestaurants() async {
    return await baseRestaurantDataSource.getRestaurants();
  }
}