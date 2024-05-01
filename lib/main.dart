import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:restaurant/features/authentication/presentation/controller/login_cubit.dart';
import 'package:restaurant/features/restaurant/presentation/controller/categories/categories_cubit.dart';
import 'package:restaurant/features/restaurant/presentation/controller/product/product_cubit.dart';
import 'package:restaurant/features/restaurant/presentation/pages/map_screen.dart';

import 'core/service/remote/service_locator.dart';
import 'features/restaurant/presentation/controller/map/map_cubit.dart';

void main() {
  ServiceLocator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<LoginCubit>(
              create: (_) => ServiceLocator.instance<LoginCubit>(),
            ),
            BlocProvider<MapCubit>(
              create: (_) => ServiceLocator.instance<MapCubit>(),
            ),
            BlocProvider<CategoriesCubit>(
              create: (_) => ServiceLocator.instance<CategoriesCubit>(),
            ),
            BlocProvider<ProductCubit>(
              create: (_) => ServiceLocator.instance<ProductCubit>(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            // You can use the library anywhere in the app even in theme
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: child,
          ),
        );
      },
      child:  LoaderOverlay(child: MapScreen()),
    );
  }
}
