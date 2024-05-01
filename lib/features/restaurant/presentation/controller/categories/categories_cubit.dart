import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant/core/service/remote/error_message_remote.dart';
import 'package:restaurant/features/restaurant/domain/entities/categories/categories_response.dart';
import 'package:restaurant/features/restaurant/domain/use_cases/get_categories.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  CategoriesCubit({required this.getCategoriesUseCase}) : super(CategoriesInitial());
  Future<void> getCategories(int branchId) async {
    emit(CategoriesLoading());
    final result = await getCategoriesUseCase.execute(branchId);
    result.fold(
            (failure) => emit(CategoriesError(errorMessage: failure.errorMessageModel)),
            (response) => emit(CategoriesLoaded( categoriesResponse: response)));
  }
}
