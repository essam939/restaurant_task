import 'package:dartz/dartz.dart';
import 'package:restaurant/core/error/failure.dart';
import 'package:restaurant/core/utilities/base_usecase.dart';
import 'package:restaurant/features/authentication/domain/entities/login_request.dart';
import 'package:restaurant/features/authentication/domain/entities/login_response.dart';
import 'package:restaurant/features/authentication/domain/repositories/base_authentication_repository.dart';




class LoginUseCase extends BaseUseCase<LoginResponse, LoginRequest> {
  final BaseAuthenticationRepository authenticationRepository;

  LoginUseCase(this.authenticationRepository);

  @override
  Future<Either<Failure, LoginResponse>> execute(LoginRequest params) async {
    return await authenticationRepository.login(params);
  }
}