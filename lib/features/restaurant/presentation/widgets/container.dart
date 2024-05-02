import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/service/remote/service_locator.dart';
import 'package:restaurant/features/restaurant/presentation/controller/counter/counter_cubit.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final counterCubit = ServiceLocator.instance<CounterCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            counterCubit.increment();
          },
          child: Container(
            height: 55.h,
            width: 50.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: Colors.green,
            ),
            child: const Center(child: Icon(Icons.add, color: Colors.white, size: 30)),
          ),
        ),
        10.horizontalSpace,
        BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Container(
              height: 55.h,
              width: 50.w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Center(child: Text(state.toString(), style:  TextStyle(fontSize: 20.sp, color: Colors.green))),
            );
          },
        ),
       10.horizontalSpace,
        GestureDetector(
          onTap: () {
            if (counterCubit.state > 1) {
              counterCubit.decrement();
            }
          },
          child: Container(
            height: 55.h,
            width: 50.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: Colors.green,
            ),
            child:  Center(child: Icon(Icons.remove, color: Colors.white, size: 30.sp)),
          ),
        ),
      ],
    );
  }
}