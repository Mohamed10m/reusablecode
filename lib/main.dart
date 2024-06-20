import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reusable_code/modules/layout/home_layout.dart';
import 'package:reusable_code/shared/componants/app_constants.dart';
import 'package:reusable_code/shared/local_database/local_datasource.dart';
import 'package:reusable_code/shared/remote_data_source/remote_data_source.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'modules/auth/auth_cubit/auth_cubit.dart';
import 'modules/auth/auth_screens/login_screen.dart';
import 'modules/layout/cubit/home_layout_cubit.dart';
import 'modules/layout/cubit/home_layout_states.dart';
import 'modules/onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppPreferences.init();

  DioHelper();
  Widget widget;

  bool? onBoarding = AppPreferences.getData('onBoarding');
  await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: HexColor('#FFFFFF').withOpacity(0.1),
  ));

  token = await AppPreferences.getData('token');

  if (onBoarding != null) {
    if (token != null) {
    widget = const HomeLayout();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatefulWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  @override
  State<MyApp> createState() => _MyAppState(startWidget);
}

class _MyAppState extends State<MyApp> {
  Widget startWidget;

  _MyAppState(this.startWidget);



  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (BuildContext context, Widget? child) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext contextApp) => HomeLayoutCubit()
          ),
          BlocProvider(
            create: (BuildContext contextApp) => AuthCubit(),
          )
        ],
        child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home:OnBoardingScreen(),

            );
          },
        ),
      );
    },
    );
  }
}
