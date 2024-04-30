import 'package:dartz/dartz.dart';
import 'package:restaurant/core/error/failure.dart';
import 'package:restaurant/features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:restaurant/features/authentication/domain/entities/login_request.dart';
import 'package:restaurant/features/authentication/domain/entities/login_response.dart';
import 'package:restaurant/features/authentication/domain/repositories/base_authentication_repository.dart';


class AuthenticationRepository extends BaseAuthenticationRepository {
  final BaseAuthenticationDataSource authenticationDataSource;

  AuthenticationRepository({required this.authenticationDataSource});

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest request) async {
    return await authenticationDataSource.login(request);
  }
}