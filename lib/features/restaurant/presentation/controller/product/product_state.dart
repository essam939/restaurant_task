part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductResponse> productResponse;
  ProductLoaded({required this.productResponse});
  @override
  List<Object> get props => [];
}

class ProductError extends ProductState {
  final ErrorMessageModel errorMessage;

  ProductError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
