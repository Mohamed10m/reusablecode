import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../shared/componants/assets_manager.dart';
import '../../../shared/componants/componants.dart';
import '../../shared/componants/fonts_manager.dart';
import '../auth/auth_cubit/auth_cubit.dart';
import '../auth/auth_cubit/auth_states.dart';
import 'otp_form.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ForgetPasswordScreen> {
  var emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          navigateTo(context, Otp(emailController: emailController.text));
        } else if (state is ResetPasswordErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.red,
              content: Center(child: Text('this email is not found'))));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: background(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20.h, bottom: 277.h, left: 20.h, right: 35.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Padding(
                        padding: EdgeInsets.only(right: 35.0.w),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      )),
                  SizedBox(
                    height: 9.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0.w),
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            width: 152,
                            height: 152,
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontConstants.cairoFontFamily),
                        )),
                        const SizedBox(
                          height: 11,
                        ),
                        Center(
                            child: Text(
                          'create new password',
                          style: TextStyle(
                              fontWeight: FontWeightManager.medium,
                              fontFamily: FontConstants.cairoFontFamily,
                              fontSize: 12,
                              color: HexColor('#212121').withOpacity(0.30)),
                        )),
                        const SizedBox(
                          height: 48,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'email',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontConstants.cairoFontFamily),
                              ),
                              SizedBox(
                                height: 11.h,
                              ),
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
                              SizedBox(
                                height: 64,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      AuthCubit.get(context).enterEmail(
                                          email: emailController.text);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      backgroundColor: HexColor('#8281F8'),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14))),
                                  child: ConditionalBuilder(
                                      condition: state
                                              is! ResetPasswordSuccessState &&
                                          state is! ResetPasswordLoadingState,
                                      builder: (context) => const Text(
                                            'reset password',
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeightManager.semiBold,
                                                fontFamily: FontConstants
                                                    .cairoFontFamily,
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
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
