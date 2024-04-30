import 'package:get_it/get_it.dart';
import 'package:restaurant/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:restaurant/authentication/data/repositories/authantication_reposiory.dart';
import 'package:restaurant/authentication/domain/repositories/base_authentication_repository.dart';
import 'package:restaurant/authentication/domain/use_cases/login_usecase.dart';
import 'package:restaurant/authentication/presentation/controller/login_cubit.dart';

import 'api_consumer.dart';
import 'dio_consumer.dart';

mixin ServiceLocator {
  static final instance = GetIt.instance;
  static void init() {
    instance.registerLazySingleton(() => LoginCubit(loginUseCase: instance()));
    // use cases
    instance.registerLazySingleton(() => LoginUseCase(instance()));
    instance.registerLazySingleton<BaseAuthenticationRepository>(
          () => AuthenticationRepository(
        authenticationDataSource: instance(),
      ),
    );
    instance.registerLazySingleton<DioConsumer>(() => ApiConsumer());

    // data source
    instance.registerLazySingleton<BaseAuthenticationDataSource>(
          () => AuthenticationDataSource(
        instance(),
      ),
    );
  }
}