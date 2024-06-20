
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reusable_code/modules/password/password_changed_successfully.dart';

import '../../../shared/componants/assets_manager.dart';
import '../../../shared/componants/componants.dart';
import '../../shared/componants/fonts_manager.dart';
import '../auth/auth_cubit/auth_cubit.dart';
import '../auth/auth_cubit/auth_states.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword(
      {super.key, required this.emailController, required this.codeController});

  final String? emailController;
  final String? codeController;
  @override
  State<CreateNewPassword> createState() =>
      _LoginScreenState(emailController, codeController);
}

class _LoginScreenState extends State<CreateNewPassword> {
  _LoginScreenState(this.emailController, this.codeController);
  String? emailController;
  String? codeController;
  var newPasswordController = TextEditingController();
  var verifyNewPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    newPasswordController.dispose();
    verifyNewPasswordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: background(
        child: BlocProvider(
          create: (BuildContext context) => AuthCubit(),
          child: BlocConsumer<AuthCubit, AuthStates>(
            listener: ((context, state) {
              if (state is ChangePasswordSuccessState) {
                navigateTo(context, const PasswordChangedSuccessfully());
              }
            }),
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 20.h),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Padding(
                        padding: EdgeInsets.only(right: 30.0.w),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(right: 35.w, left: 30.w, bottom: 154.h),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 151,
                              height: 151,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/Ellipse 2.png"),
                                      fit: BoxFit.cover)),
                              child: const Image(
                                image: AssetImage(ImageAssets.background),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Center(
                              child: Text(
                                'name',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontConstants.cairoFontFamily,
                                    fontSize: 20),
                              )),
                          const SizedBox(
                            height: 11,
                          ),
                          Center(
                              child: Text(
                                'last name',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontConstants.cairoFontFamily,
                                    fontSize: 12,
                                    color: HexColor('#212121').withOpacity(0.30)),
                              )),
                          const SizedBox(
                            height: 48,
                          ),
                          const Text(
                            'password',
                            style: TextStyle(
                                fontWeight: FontWeightManager.medium,
                                fontFamily: FontConstants.cairoFontFamily),
                          ),
                          SizedBox(
                            height: 11.h,
                          ),
                          customFormField(
                            valueKey: 'Password',
                            text: "*******",
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                //
                              } else {
                                return null;
                              }
                              return null;
                            },
                            suffix: AuthCubit.get(context).suffix,
                            suffixPressed: () {
                              AuthCubit.get(context).changePasswordVisibility();
                            },
                            obSecureText: AuthCubit.get(context).isPassword,
                            controller: newPasswordController,
                          ),
                          SizedBox(
                            height: 32.h,
                          ),
                          const Text('Confirm Password',
                              style: TextStyle(
                                  fontWeight: FontWeightManager.medium,
                                  fontFamily: FontConstants.cairoFontFamily)),
                          SizedBox(
                            height: 11.h,
                          ),
                          customFormField(
                            valueKey: 'Confirm Password',
                            text: "*******",
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                //
                              } else {
                                return null;
                              }
                              return null;
                            },
                            suffix: AuthCubit.get(context).suffix,
                            suffixPressed: () {
                              AuthCubit.get(context).changePasswordVisibility();
                            },
                            obSecureText: AuthCubit.get(context).isPassword,
                            controller: verifyNewPasswordController,
                          ),
                          SizedBox(
                            height: 32.h,
                          ),
                          SizedBox(
                            height: 64,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  AuthCubit.get(context).changePassword(
                                      email: emailController,
                                      code: codeController,
                                      newPassword: newPasswordController.text,
                                      newPasswordConfirmation:
                                      verifyNewPasswordController.text);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: HexColor('#8281F8'),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(38))),
                              child: ConditionalBuilder(
                                  condition:
                                  state is! ChangePasswordSuccessState &&
                                      state is! ChangePasswordLoadingState,
                                  builder: (context) => const Text(
                                    'Reset Password',
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeightManager.semiBold,
                                        fontFamily:
                                        FontConstants.cairoFontFamily,
                                        fontSize: 20),
                                  ),
                                  fallback: (context) =>
                                  const CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
