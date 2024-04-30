
part of '../../pages/login_screen.dart';

class _LoginBackground extends StatelessWidget {
  final Widget body;
  const _LoginBackground({required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width:  MediaQuery.sizeOf(context).width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.sp),topRight: Radius.circular(30.sp)),
      ),
      child: body,
    );
  }
}