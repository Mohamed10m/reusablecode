import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/auth_model.dart';

import '../../../models/change_password.dart';
import '../../../models/check_code_model.dart';
import '../../../models/login_model.dart';
import '../../../models/reset_password_model.dart';
import '../../../shared/end_points/end_points.dart';
import '../../../shared/remote_data_source/remote_data_source.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AppLoginInitialStates());

  static AuthCubit get(context) => BlocProvider.of(context);

  AuthModel? authModel;

  void userRegister({required String name,
    required String email,
    String? password,
    String? confirmPassword,
    required String phone}) {
    emit(AppRegisterLoadingStates());

    DioHelper.postData(
      path: register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
        'phone': phone
      },
    ).then((value) {
      authModel = AuthModel.fromJson(value.data);

      emit(AppRegisterSuccessStates(authModel!));
    }).catchError((error) {
      emit(AppRegisterErrorStates());
    });
  }

  LoginModel? loginModel;

  void userLogin({required String email, required String password}) {
    emit(AppLoginLoadingStates());
    DioHelper.postData(
      path: login,
      data: {"email": email, "password": password},
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(AppLoginSuccessStates(loginModel!));
    }).catchError((error) {
      emit(AppLoginErrorStates());
    });
  }


  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppChangePasswordStates());
  }


  ResetPasswordModel? resetPasswordModel;

  void enterEmail({
    required String email,
  }) {
    emit(ResetPasswordLoadingState());

    DioHelper.postData(
      path: resetPassword,
      data: {
        'email': email,
      },
    ).then((value) {
      resetPasswordModel = ResetPasswordModel.fromJson(value.data);

      emit(ResetPasswordSuccessState());
    }).catchError((error) {
      emit(ResetPasswordErrorState());
    });
  }


  ChangePasswordModel? changePasswordModel;

  void changePassword({
    String? email,
    String? code,
    String? newPassword,
    String? newPasswordConfirmation,
  }) {
    emit(ChangePasswordLoadingState());
    DioHelper.postData(
      path: changePass,
      data: {
        'email': email,
        'code': code,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirmation,
      },
    ).then((value) {
      emit(ChangePasswordSuccessState());
    }).catchError((error) {
      emit(ChangePasswordErrorState());
    });
  }

  CheckCodeModel? checkCodeModel;

  void checkCode({
    String? email,
    String? code,
  }) {
    emit(CheckCodeLoadingState());
    DioHelper.postData(
      path: check,
      data: {
        'email': email,
        'code': code,
      },
    ).then((value) {
      emit(CheckCodeSuccessState());
    }).catchError((error) {
      emit(CheckCodeErrorState());
    });
  }
}