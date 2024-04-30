part of '../../pages/login_screen.dart';
class _CreateNewAccount extends StatelessWidget {
  const _CreateNewAccount();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.verticalSpace,
        GestureDetector(
          onTap: (){},
          child: RichText(
              text: const TextSpan(
                  text: 'Don\'t have an account?',
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                        text: 'Sign up',
                        style: TextStyle(color: Colors.black))
                  ])),
        ),
      ],
    );
  }
}