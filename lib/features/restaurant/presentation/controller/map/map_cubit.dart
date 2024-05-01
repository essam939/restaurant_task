import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant/core/service/remote/error_message_remote.dart';
import 'package:restaurant/core/utilities/base_usecase.dart';
import 'package:restaurant/features/restaurant/domain/entities/map/map_response.dart';
import 'package:restaurant/features/restaurant/domain/use_cases/get_restaurants.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final GetRestaurantsUseCase getRestaurantsUseCase;
  MapCubit({required this.getRestaurantsUseCase}) : super(MapInitial());
  Future<void> getRestaurants() async {
    emit(MapLoading());
    final result = await getRestaurantsUseCase.execute(const NoParams());
    result.fold(
        (failure) => emit(MapError(errorMessage: failure.errorMessageModel)),
        (mapResponse) => emit(MapLoaded(mapResponse: mapResponse)));
  }
}
