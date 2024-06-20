import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../shared/componants/app_strings.dart';
import '../../shared/componants/assets_manager.dart';
import 'onboarding_screen.dart';

List<BoardingModel> boarding = [
  BoardingModel(
      container: Container(
        height: 240.h,
        width: 210.w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.background),
          ),
        ),
        child:Image.asset(
          ImageAssets.background,scale: 1.2,
        ),
      ),
      title: AppStrings.onBoardingTitle1,
      subTitle: AppStrings.onBoardingSubTitle1),
  BoardingModel(
      container: Container(
        height: 240.h,
        width: 210.w,
        decoration:  const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.background),
            )),
        child:   const Image(
          image: AssetImage(ImageAssets.background),
        ),
      ),
      title: AppStrings.onBoardingTitle2,
      subTitle: AppStrings.onBoardingSubTitle2),
  BoardingModel(
      container: Container(
        height: 240.h,
        width: 210.w,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.background),
            )),
        child:  const Image(
          image: AssetImage(ImageAssets.background),
        ),
      ),
      title: AppStrings.onBoardingTitle3,
      subTitle: AppStrings.onBoardingSubTitle3),
];

Widget buildBoardingImage(BoardingModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    model.container,
    SizedBox(height: 50.h),
    Text(
      model.title,
      style: TextStyle(
          color: HexColor('#212121'),
          fontWeight: FontWeight.bold,
          // fontFamily: FontConstants.cairoFontFamily,
          fontSize: 25.sp),
    ),
    SizedBox(height: 10.h,),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.0.w),
      child:  Text(
        model.subTitle,

        style: const TextStyle(
            fontSize: 14,
            ),
        softWrap: true,
        textAlign: TextAlign.center,
      ),
    ),
  ],
);
