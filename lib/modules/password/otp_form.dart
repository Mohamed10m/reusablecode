import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/componants/assets_manager.dart';
import '../../shared/componants/componants.dart';
import '../auth/auth_cubit/auth_cubit.dart';
import '../auth/auth_cubit/auth_states.dart';
import 'create_new_password.dart';

class Otp extends StatefulWidget {
  const Otp({super.key, required this.emailController});

  final String? emailController;
  @override
  _OtpState createState() => _OtpState(emailController);
}

class _OtpState extends State<Otp> {
  String? emailController;
  _OtpState(this.emailController);

  var codeController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is CheckCodeSuccessState) {
            navigateTo(
                context,
                CreateNewPassword(
                  emailController: emailController,
                  codeController: codeController.text,
                ));
          }
        },
        builder: (context, state) => Scaffold(
          resizeToAvoidBottomInset: true,
          body: background(
            child: SafeArea(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment:  CrossAxisAlignment.start,
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
                      const SizedBox(
                        height: 18,
                      ),
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                ImageAssets.background,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const Text(
                              'Verification',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Enter your OTP code number",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            Container(
                              padding: const EdgeInsets.all(28),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  customFormField(
                                      valueKey: 'enter code',
                                      text: 'enter code',
                                      controller: codeController,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'code must not be empty';
                                        }
                                        return null;
                                      }),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          AuthCubit.get(context).checkCode(
                                              email: emailController,
                                              code: codeController.text);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                         Colors.red,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(24))),
                                      child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: ConditionalBuilder(
                                              condition: state
                                              is! CheckCodeLoadingState &&
                                                  state
                                                  is! CheckCodeSuccessState,
                                              builder: (context) => const Text(
                                                'Verify',
                                                style:
                                                TextStyle(fontSize: 16),
                                              ),
                                              fallback: (context) =>
                                              const CircularProgressIndicator(
                                                color: Colors.white,
                                              ))),
                                    ),
                                  )
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
            ),
          ),
        ),
      ),
    );
  }
}
