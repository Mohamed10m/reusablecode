import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reusable_code/modules/auth/auth_screens/login_screen.dart';
import 'package:reusable_code/modules/settings_screen/widgets.dart';

import '../../shared/componants/assets_manager.dart';
import '../../shared/componants/componants.dart';
import '../../shared/componants/fonts_manager.dart';
import '../layout/cubit/home_layout_cubit.dart';
import '../layout/cubit/home_layout_states.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {


    return ConditionalBuilder(
        condition:true,
        builder: (BuildContext context) =>  BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Padding(
                  padding: EdgeInsets.only(right: 20.0.w, left: 20.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 81.h,
                      ),
                      const Image(image: AssetImage(ImageAssets.background)),
                      SizedBox(
                        height: 16.h,
                      ),
                      const Text(
                        'saas',
                        // cubit.userDataModel!.name!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: FontConstants.cairoFontFamily,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 11.h,
                      ),
                      Text(
                        'assa',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: HexColor('#212121').withOpacity(0.5),
                            fontFamily: 'Poppins'),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      buildSettingsCardItem(
                        leftWidth: 10,
                        rightWidth: 27,
                        color: HexColor("#8281F8").withOpacity(0.04),
                        iconColor: HexColor('#8281F8'),
                        text: 'as',
                        image: ImageAssets.background,
                        context: context,
                        function: (){
                          navigateTo(context,  BlocProvider.value(
                              value: HomeLayoutCubit.get(context)..getUserData(),
                              child: const LoginScreen())
                          );
                        },
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      buildSettingsCardItem(
                        leftWidth:  10,
                        rightWidth:  27,
                        color: HexColor("#8281F8").withOpacity(0.04),
                        text: 'sasa',
                        iconColor: HexColor('#8281F8'),
                        image: ImageAssets.background,
                        context: context,
                        function: (){
                          navigateTo(context, const LoginScreen());
                        },
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      buildSettingsCardItem(
                        leftWidth:  10,
                        rightWidth: 27,
                        color: HexColor("#8281F8").withOpacity(0.04),
                        text: 'sa',
                        iconColor: HexColor('#8281F8'),
                        image: ImageAssets.background,
                        context: context,
                        function: (){
                        //
                        },
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      buildSettingsCardItem(
                        leftWidth:  10,
                        rightWidth: 27,
                        color: HexColor("#8281F8").withOpacity(0.04),
                        text: 'sa',
                        iconColor: HexColor('#8281F8'),
                        image: ImageAssets.background,
                        context: context,
                        function: (){
                          navigateTo(context, const LoginScreen());
                        },
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      buildSettingsCardItem(
                        leftWidth:  10,
                        rightWidth: 27,
                        color: HexColor("#8281F8").withOpacity(0.04),
                        text:'sa',
                        iconColor: HexColor('#8281F8'),
                        image: ImageAssets.background,
                        context: context,
                        function: (){
                          navigateTo(context, const LoginScreen());
                        },
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      buildSettingsCardItem(
                        leftWidth:  10,
                        rightWidth: 27,
                        color: HexColor("#8281F8").withOpacity(0.04),
                        text: 'sda',
                        iconColor: HexColor('#8281F8'),
                        image: ImageAssets.background,
                        context: context,
                        function: (){
                          navigateTo(context, const LoginScreen());
                        },
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      buildSettingsCardItem(
                        leftWidth:  10,
                        rightWidth:  27,
                        color: HexColor("#FF725E").withOpacity(0.06),
                        text:'kk',
                        style: TextStyle(
                          color: HexColor('#FF725E'),
                          fontWeight: FontWeight.bold,
                          fontFamily: FontConstants.cairoFontFamily,
                          fontSize: 16,
                        ),
                        iconColor: HexColor('#FF725E'),
                        image: ImageAssets.background,
                        context: context,
                        function:(){
                          // signOut(context);
                        },
                      ),
                    ],
                  ));
            }), fallback: (context)=>const Center(
        child: CircularProgressIndicator()));



  }
}
