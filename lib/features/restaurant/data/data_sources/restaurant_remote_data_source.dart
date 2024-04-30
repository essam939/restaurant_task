 import 'package:dartz/dartz.dart';
import 'package:restaurant/core/error/failure.dart';
import 'package:restaurant/core/service/remote/dio_consumer.dart';
import 'package:restaurant/features/restaurant/domain/entities/map_response.dart';
 part 'endpoints.dart';
 abstract class BaseRestaurantDataSource {
  Future<Either<Failure, MapResponse>> getRestaurants();
}
class RestaurantDataSource extends BaseRestaurantDataSource {
 final DioConsumer _dio;

 RestaurantDataSource(this._dio);

 @override
 Future<Either<Failure, MapResponse>> getRestaurants() async {
  {
   final responseEither = await _dio.get(
    _RestaurantEndPoints.getRestaurants,
   );
   return responseEither.fold(
        (failure) => Left(failure),
        (response) =>
        Right(
         MapResponse.fromJson(
          response!['data'] as Map<String, dynamic>,
         ),
        ),
   );
  }
 }
}