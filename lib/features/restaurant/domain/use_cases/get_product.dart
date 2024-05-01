import 'package:dartz/dartz.dart';
import 'package:restaurant/core/error/failure.dart';
import 'package:restaurant/core/utilities/base_usecase.dart';
import 'package:restaurant/features/restaurant/domain/entities/product/product_response.dart';

import '../repositories/base_restaurant_repository.dart';

class GetProductUseCase extends BaseUseCase<List<ProductResponse>, int > {
  final BaseRestaurantRepository restaurantRepository;

  GetProductUseCase(this.restaurantRepository);

  @override
  Future<Either<Failure, List<ProductResponse>>> execute(int categoryId) async {
    return await restaurantRepository.getProducts(categoryId);
  }
}