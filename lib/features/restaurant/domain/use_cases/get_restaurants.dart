
import 'package:dartz/dartz.dart';
import 'package:restaurant/core/error/failure.dart';
import 'package:restaurant/core/utilities/base_usecase.dart';
import 'package:restaurant/features/restaurant/domain/entities/map_response.dart';
import 'package:restaurant/features/restaurant/domain/repositories/base_restaurant_repository.dart';

class GetRestaurantsUseCase extends BaseUseCase<MapResponse, NoParams> {
  final BaseRestaurantRepository restaurantRepository;

  GetRestaurantsUseCase(this.restaurantRepository);

  @override
  Future<Either<Failure, MapResponse>> execute(NoParams params) async {
    return await restaurantRepository.getRestaurants();
  }
}