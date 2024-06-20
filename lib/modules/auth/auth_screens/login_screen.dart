import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reusable_code/modules/auth/auth_screens/regester_screen.dart';

import '../../../shared/componants/app_constants.dart';
import '../../../shared/componants/assets_manager.dart';
import '../../../shared/componants/componants.dart';
import '../../../shared/componants/fonts_manager.dart';

import '../../../shared/local_database/local_datasource.dart';
import '../../layout/cubit/home_layout_cubit.dart';
import '../../layout/home_layout.dart';
import '../../password/forget_password.dart';
import '../auth_cubit/auth_cubit.dart';
import '../auth_cubit/auth_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    return BlocProvider(
      create: (BuildContext context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is AppLoginSuccessStates) {
            if (state.loginModel.status!) {
              AppPreferences.saveData('token', state.loginModel.token)
                  .then((value) {
                token = state.loginModel.token;
                navigateAndFinish(
                    context,
                    BlocProvider.value(
                      value: HomeLayoutCubit.get(context),
                      child: const HomeLayout(),
                    ));
              });
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: background(
              child: Padding(
                padding: EdgeInsets.only(top: 68.h),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: HexColor('#EC8E6C').withOpacity(0.1),
                      child: const Image(
                        width: 152,
                        height: 152,
                        image: AssetImage(ImageAssets.background),
                      ),
                    ),
                    SizedBox(
                      height: 19.h,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(32),
                            topLeft: Radius.circular(32)),
                        border: Border.all(
                            color: HexColor('#FCC885').withOpacity(0.30),
                            width: 1),
                        color: HexColor('#FFFFFF').withOpacity(0.40),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 35.h, vertical: 32.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'email',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeightManager.regular,
                                  fontFamily: FontConstants.cairoFontFamily),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customFormField(
                                      valueKey: 'Email',
                                      text: "Example@gmail.com",
                                      hintStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeightManager.medium,
                                          fontFamily:
                                          FontConstants.poppinsFontFamily),
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Email must not be empty';
                                        } else if (!RegExp(
                                            "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                            .hasMatch(value)) {
                                          return 'Please a valid Email';
                                        }
                                        return null;
                                      },
                                      controller: emailController,
                                      type: TextInputType.emailAddress,
                                    ),
                                    SizedBox(
                                      height: 32.h,
                                    ),
                                    const Text(
                                      'password',
                                      style: TextStyle(
                                          fontWeight: FontWeightManager.regular,
                                          fontFamily:
                                          FontConstants.poppinsFontFamily),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    customFormField(
                                      valueKey: 'Password',
                                      text: "*********",
                                      hintStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeightManager.medium,
                                          fontFamily:
                                          FontConstants.poppinsFontFamily),
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Password must not be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                      suffix: AuthCubit.get(context).suffix,
                                      suffixPressed: () {
                                        AuthCubit.get(context)
                                            .changePasswordVisibility();
                                      },
                                      obSecureText:
                                      AuthCubit.get(context).isPassword,
                                      controller: passwordController,
                                      type: TextInputType.number,
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: 11.h,
                            ),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                    onPressed: () {
                                      navigateTo(
                                          context,
                                          BlocProvider.value(
                                            value: AuthCubit.get(context),
                                            child:
                                            const ForgetPasswordScreen(),
                                          ));
                                    },
                                    child: Text(
                                      'Forget Password',
                                      style: TextStyle(
                                          color: HexColor('#8281F8'),
                                          fontSize: 14.sp,
                                          fontWeight:
                                          FontWeightManager.semiBold,
                                          fontFamily: FontConstants
                                              .cairoFontFamily),
                                    ))),
                            SizedBox(
                              height: 39.h,
                            ),
                            SizedBox(
                              height: 64.h,
                              width: 320.w,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    AuthCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    backgroundColor: HexColor('#8281F8'),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(14))),
                                child: ConditionalBuilder(
                                    condition:
                                    state is! AppLoginLoadingStates &&
                                        state is! AppLoginSuccessStates,
                                    builder: (BuildContext context) => const Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontConstants
                                              .cairoFontFamily),
                                    ),
                                    fallback: (BuildContext context) =>
                                    const CircularProgressIndicator(
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //     MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Container(
                            //         padding: const EdgeInsets.all(10),
                            //         decoration: BoxDecoration(
                            //             borderRadius: const BorderRadius.all(
                            //                 Radius.circular(10)),
                            //             color: HexColor('#EC8E6C')
                            //                 .withOpacity(0.1)),
                            //         child: IconButton(
                            //           icon: Image.asset(
                            //               'assets/images/facebook_icon.png'),
                            //           onPressed: () {
                            //
                            //           },
                            //         ),
                            //       ),
                            //       Container(
                            //         padding: const EdgeInsets.all(10),
                            //         decoration: BoxDecoration(
                            //             borderRadius: const BorderRadius.all(
                            //                 Radius.circular(10)),
                            //             color: HexColor('#EC8E6C')
                            //                 .withOpacity(0.1)),
                            //         child: IconButton(
                            //           icon: Image.asset(
                            //               'assets/images/apple.png'),
                            //           onPressed: () {
                            //             // AuthCubit.get(context).appleSignIn();
                            //           },
                            //         ),
                            //       ),
                            //       Container(
                            //         padding: const EdgeInsets.all(10),
                            //         decoration: BoxDecoration(
                            //             borderRadius: const BorderRadius.all(
                            //                 Radius.circular(10)),
                            //             color: HexColor('#EC8E6C')
                            //                 .withOpacity(0.1)),
                            //         child: IconButton(
                            //           icon: Image.asset(
                            //               'assets/images/google.png'),
                            //           onPressed: () {
                            //
                            //           },
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(height: 52.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'don\'t have an account',
                                  style: TextStyle(
                                      fontWeight: FontWeightManager.medium,
                                      fontFamily: FontConstants.cairoFontFamily,
                                      fontSize: 16),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const RegisterScreen()));
                                  },
                                  child: Text(
                                    'register now',
                                    style: TextStyle(
                                        color: HexColor('#8281F8'),
                                        fontSize: 16.sp,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeightManager.medium,
                                        fontFamily:
                                        FontConstants.cairoFontFamily),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
