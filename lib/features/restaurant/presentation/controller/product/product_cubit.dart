import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:restaurant/core/service/remote/error_message_remote.dart';
import 'package:restaurant/features/restaurant/domain/entities/product/product_response.dart';
import 'package:restaurant/features/restaurant/domain/use_cases/get_product.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductUseCase getProductUseCase;
  ProductCubit({required this.getProductUseCase}) : super(ProductInitial());
  Future<void> getProducts(int categoryId) async {
    emit(ProductLoading());
    final result = await getProductUseCase.execute(categoryId);
    result.fold(
            (failure) => emit(ProductError(errorMessage: failure.errorMessageModel)),
            (response) => emit(ProductLoaded( productResponse: response)));
  }
}
