import 'package:dartz/dartz.dart';
import 'package:restaurant/core/error/failure.dart';
import 'package:restaurant/core/utilities/base_usecase.dart';
import 'package:restaurant/features/restaurant/domain/entities/categories/categories_response.dart';
import 'package:restaurant/features/restaurant/domain/repositories/base_restaurant_repository.dart';

class GetCategoriesUseCase extends BaseUseCase<List<CategoriesResponse>, int > {
  final BaseRestaurantRepository restaurantRepository;

  GetCategoriesUseCase(this.restaurantRepository);

  @override
  Future<Either<Failure, List<CategoriesResponse>>> execute(int id) async {
    return await restaurantRepository.getCategories(id);
  }
}