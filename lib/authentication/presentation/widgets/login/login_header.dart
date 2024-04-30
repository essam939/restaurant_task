part of '../../pages/login_screen.dart';


class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        45.verticalSpace,
        Center(
          child: Text(
            "Login Screen",
            style: TextStyle(
              fontSize: 25.sp,
              color: Colors.black,
            ),
          ),
        ),
        20.verticalSpace,
      ],
    );
  }
}