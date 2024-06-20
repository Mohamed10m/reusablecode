import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reusable_code/modules/settings_screen/settings_screen.dart';

import '../../shared/componants/assets_manager.dart';
import '../../shared/componants/componants.dart';
import '../booking_screen/booking_screen.dart';
import '../home_screen/home_screen.dart';
import 'cubit/home_layout_cubit.dart';
import 'cubit/home_layout_states.dart';

class HomeLayout extends StatefulWidget {
  const  HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}
class _HomeLayoutState extends State<HomeLayout> {
  _HomeLayoutState();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) => HomeLayoutCubit()
          ..getUserData(),
        child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeLayoutCubit.get(context);
            List<Widget> bottomScreens = [
              const HomeScreen(),
              const BookingScreen(),
              const SettingScreen(),
            ];
            return Scaffold(
              body: background(
                child: bottomScreens[cubit.currentIndex],
              ),
              bottomNavigationBar: Container(
                color: HexColor("#eaeaf5"),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 18.0.h,
                    right: 30.w,
                    left: 30.w,
                    top: 15.h,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      height: 75,
                      width: MediaQuery.of(context).size.width,
                      child: BottomNavigationBar(
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        elevation: 0.0,
                        backgroundColor: HexColor("#e2e1fc"),
                        currentIndex: cubit.currentIndex,
                        onTap: (index) => cubit.changeBottom(index),
                        items: const [
                          BottomNavigationBarItem(
                            activeIcon: Column(
                              children: [
                                Image(
                                  height: 24,
                                  width: 25,
                                  image: AssetImage(ImageAssets.background),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Image(image: AssetImage(ImageAssets.background)),
                              ],
                            ),
                            icon: Column(
                              children: [
                                Image(
                                  height: 24,
                                  width: 25,
                                  image: AssetImage(ImageAssets.background),
                                ),
                              ],
                            ),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                              activeIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    height: 24,
                                    width: 25,
                                    image:
                                    AssetImage(ImageAssets.background),
                                  ),
                                  SizedBox(height: 8),
                                  Image(
                                      image: AssetImage(ImageAssets.background)),
                                ],
                              ),
                              icon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    height: 24,
                                    width: 25,
                                    image:
                                    AssetImage(ImageAssets.background),
                                  ),
                                ],
                              ),
                              label: ''),
                          BottomNavigationBarItem(
                            activeIcon: Column(
                              children: [
                                Image(
                                  height: 24,
                                  width: 25,
                                  image: AssetImage(ImageAssets.background),
                                ),
                                SizedBox(height: 8),
                                Image(image: AssetImage(ImageAssets.background)),
                              ],
                            ),
                            icon: Column(
                              children: [
                                Image(
                                  height: 24,
                                  width: 25,
                                  image: AssetImage(ImageAssets.background),
                                ),
                              ],
                            ),
                            label: '',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
