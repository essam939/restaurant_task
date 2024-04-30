import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurant/core/service/simple_secure_user_data.dart';
import 'package:restaurant/core/service/simple_user_data.dart';
import 'package:restaurant/features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:restaurant/features/authentication/data/repositories/authantication_reposiory.dart';
import 'package:restaurant/features/authentication/domain/repositories/base_authentication_repository.dart';
import 'package:restaurant/features/authentication/domain/use_cases/login_usecase.dart';
import 'package:restaurant/features/authentication/presentation/controller/login_cubit.dart';
import 'package:restaurant/features/restaurant/data/data_sources/restaurant_remote_data_source.dart';
import 'package:restaurant/features/restaurant/data/repositories/restaurant_repository.dart';
import 'package:restaurant/features/restaurant/domain/repositories/base_restaurant_repository.dart';
import 'package:restaurant/features/restaurant/domain/use_cases/get_restaurants.dart';
import 'package:restaurant/features/restaurant/presentation/controller/map/map_cubit.dart';

import 'api_consumer.dart';
import 'dio_consumer.dart';

mixin ServiceLocator {
  static final instance = GetIt.instance;
  static void init() {
    instance.registerLazySingleton(() => LoginCubit(loginUseCase: instance()));
    instance.registerLazySingleton(() => MapCubit(getRestaurantsUseCase: instance()));
    // use cases
    instance.registerLazySingleton(() => LoginUseCase(instance()));
    instance.registerLazySingleton(() => GetRestaurantsUseCase(instance()));

    instance.registerLazySingleton<BaseAuthenticationRepository>(
          () => AuthenticationRepository(
        authenticationDataSource: instance(),
      ),
    );
    instance.registerLazySingleton<BaseRestaurantRepository>(
          () => RestaurantRepository(
        baseRestaurantDataSource: instance(),
      ),
    );
    instance.registerLazySingleton(() => const SimpleLocalData());
    instance.registerLazySingleton(() => SimpleSecureData(instance()));
    instance.registerLazySingleton<DioConsumer>(() => ApiConsumer());
    instance.registerLazySingleton(() => const FlutterSecureStorage());

    // data source
    instance.registerLazySingleton<BaseAuthenticationDataSource>(
          () => AuthenticationDataSource(
        instance(),
      ),
    );
    instance.registerLazySingleton<BaseRestaurantDataSource>(
          () => RestaurantDataSource(
        instance(),
      ),
    );
  }
}