import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/core/service/local/interface/i_simple_user_data.dart';
import 'package:restaurant/core/service/local/user_data_factory.dart';
import 'package:restaurant/core/service/remote/error_message_remote.dart';
import 'package:restaurant/core/utilities/enums.dart';
import 'package:restaurant/features/authentication/domain/entities/login_request.dart';
import 'package:restaurant/features/authentication/domain/entities/login_response.dart';
import 'package:restaurant/features/authentication/domain/use_cases/login_usecase.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ISimpleUserData userData =
  UserDataFactory.createUserData(LocalDataType.secured);
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
          userData.writeJsonMap(
            "userData",
            user.toJson(),
          );
          emit(
            LoginLoaded(userData: user),
          );
        },
      );
    }
  }
}
