import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/componants/fonts_manager.dart';
import '../layout/cubit/home_layout_cubit.dart';
import '../layout/cubit/home_layout_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return ConditionalBuilder(
          condition:true,
          builder: (BuildContext context) => Column(children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 60.h, right: 34.w, left: 36.w, bottom: 40.h),
              child: Row(
                children: [
                  SizedBox(
                    width: 16.w,
                  ),
                  const Text(
                    'as',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: FontConstants.cairoFontFamily,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ]),
          fallback: (context) => Column(
            children: [
              SizedBox(
                height: 300.h,
              ),
              const Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }
}
