part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final LoginResponse userData;
  LoginLoaded({required this.userData});
  @override
  List<Object> get props => [];
}

class LoginError extends LoginState {
  final ErrorMessageModel errorMessage;

  LoginError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
