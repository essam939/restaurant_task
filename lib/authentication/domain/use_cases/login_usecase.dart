import 'package:dartz/dartz.dart';
import 'package:restaurant/authentication/core/utilities/base_usecase.dart';
import 'package:restaurant/authentication/domain/entities/login_request.dart';
import 'package:restaurant/authentication/domain/entities/login_response.dart';
import 'package:restaurant/authentication/domain/repositories/base_authentication_repository.dart';
import 'package:restaurant/authentication/core/error/failure.dart';



class LoginUseCase extends BaseUseCase<LoginResponse, LoginRequest> {
  final BaseAuthenticationRepository authenticationRepository;

  LoginUseCase(this.authenticationRepository);

  @override
  Future<Either<Failure, LoginResponse>> execute(LoginRequest params) async {
    return await authenticationRepository.login(params);
  }
}