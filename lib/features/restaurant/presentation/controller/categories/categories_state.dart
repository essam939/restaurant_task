part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<CategoriesResponse> categoriesResponse;
  CategoriesLoaded({required this.categoriesResponse});
  @override
  List<Object> get props => [];
}

class CategoriesError extends CategoriesState {
  final ErrorMessageModel errorMessage;

  CategoriesError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
