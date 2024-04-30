import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:restaurant/core/service/remote/service_locator.dart';
import 'package:restaurant/core/widget_life_cycle_listener.dart';
import 'package:restaurant/features/authentication/presentation/controller/login_cubit.dart';
import 'package:restaurant/features/restaurant/presentation/pages/home_screen.dart';

part '../widgets/login/login_header.dart';
part '../widgets/login/login_form.dart';
part '../widgets/login/login_background.dart';
part '../widgets/login/forget_password.dart';
part '../widgets/login/create_new_account.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          context.loaderOverlay.show();
        } else if (state is LoginLoaded) {
          context.loaderOverlay.hide();
          Navigator.push(context, MaterialPageRoute(builder: (_)=> MapScreen()));
        } else if (state is LoginError) {
          context.loaderOverlay.hide();
          var snackBar = SnackBar(
            content: Text(state.errorMessage.msg),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
          ),
          backgroundColor: Colors.green,
          body: const _LoginBackground(
            body: SingleChildScrollView(
                child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    _LoginHeader(),
                    _LoginForm(),
                    _ForgetPassword(),
                    _CreateNewAccount(),
                  ],
                ),
              ),
            )),
          )),
    );
  }
}
