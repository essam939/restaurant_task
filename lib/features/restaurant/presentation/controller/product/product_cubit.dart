import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/core/service/remote/error_message_remote.dart';
import 'package:restaurant/features/restaurant/domain/entities/product/product_request.dart';
import 'package:restaurant/features/restaurant/domain/entities/product/product_response.dart';
import 'package:restaurant/features/restaurant/domain/use_cases/get_product.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductUseCase getProductUseCase;
  ProductCubit({required this.getProductUseCase}) : super(ProductInitial());
  Future<void> getProducts(ProductsRequest productsRequest) async {
    emit(ProductLoading());
    final result = await getProductUseCase.execute(productsRequest);
    result.fold(
            (failure) => emit(ProductError(errorMessage: failure.errorMessageModel)),
            (response) => emit(ProductLoaded( productResponse: response)));
  }

  void reset() {
    emit(ProductInitial());
  }
}
