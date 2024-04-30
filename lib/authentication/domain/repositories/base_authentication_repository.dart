import 'package:dartz/dartz.dart';
import 'package:restaurant/authentication/core/error/failure.dart';
import 'package:restaurant/authentication/domain/entities/login_request.dart';
import 'package:restaurant/authentication/domain/entities/login_response.dart';



abstract class BaseAuthenticationRepository {
  Future<Either<Failure, LoginResponse>> login(LoginRequest request);
}