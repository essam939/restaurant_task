import 'package:dartz/dartz.dart';
import 'package:restaurant/authentication/core/error/failure.dart';
import 'package:restaurant/authentication/core/service/remote/dio_consumer.dart';
import 'package:restaurant/authentication/domain/entities/login_request.dart';
import 'package:restaurant/authentication/domain/entities/login_response.dart';

part 'endpoints.dart';
abstract class BaseAuthenticationDataSource {
  Future<Either<Failure, LoginResponse>> login(LoginRequest request);
}
class AuthenticationDataSource extends BaseAuthenticationDataSource {
  final DioConsumer _dio;
  AuthenticationDataSource(this._dio);
  @override
  Future<Either<Failure, LoginResponse>> login(
      LoginRequest request,
      ) async {
    final responseEither = await _dio.post(
      _AuthEndPoints.login,
      data: request.toJson(),
    );
    return responseEither.fold(
          (failure) => Left(failure),
          (response) => Right(
        LoginResponse.fromJson(
          response!['data'] as Map<String, dynamic>,
        ),
      ),
    );
  }

}