import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/authentication/core/service/remote/error_message_remote.dart';
import 'package:restaurant/authentication/domain/entities/login_request.dart';
import 'package:restaurant/authentication/domain/entities/login_response.dart';
import 'package:restaurant/authentication/domain/use_cases/login_usecase.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  LoginCubit({required this.loginUseCase}) : super(LoginInitial());
  Future<void> login() async {
    if (loginFormKey.currentState!.validate()) {
      emit(LoginLoading());
      final result = await loginUseCase.execute(
        LoginRequest(
          phone: phoneController.text,
          password: passwordController.text,
        ),
      );

      result.fold(
        (failure) => emit(
          LoginError(errorMessage: failure.errorMessageModel),
        ),
        (user) {
          emit(
            LoginLoaded(userData: user),
          );
        },
      );
    }
  }
}
