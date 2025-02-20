
import '../../../models/auth_model.dart';
import '../../../models/login_model.dart';

abstract class AuthStates {}

// Register States
class AppLoginInitialStates extends AuthStates {}

class AppRegisterLoadingStates extends AuthStates {}

class AppRegisterSuccessStates extends AuthStates {
  final AuthModel authModel;

  AppRegisterSuccessStates(this.authModel);
}

class AppRegisterErrorStates extends AuthStates {}

// LoginStates

class AppLoginSuccessStates extends AuthStates {
  final LoginModel loginModel;

  AppLoginSuccessStates(this.loginModel);
}

class AppLoginLoadingStates extends AuthStates {}

class AppLoginErrorStates extends AuthStates {
  final LoginModel ?loginModel;
  AppLoginErrorStates({this.loginModel});

}


class AppChangePasswordStates extends AuthStates {}

class ResetPasswordLoadingState extends AuthStates {}

class ResetPasswordSuccessState extends AuthStates {}

class ResetPasswordErrorState extends AuthStates {}

class ChooseBarberInitialStates extends AuthStates {}

class GetSuccessChooseBarberData extends AuthStates {}


class GetErrorChoosesData extends AuthStates {}

abstract class GetBarberStates {}

class ChangePasswordLoadingState extends AuthStates {}

class ChangePasswordSuccessState extends AuthStates {}

class ChangePasswordErrorState extends AuthStates {}
class EnterPasswordLoadingState extends AuthStates {}

class EnterPasswordSuccessState extends AuthStates {}

class EnterPasswordErrorState extends AuthStates {}
class EnterCodeVerificationErrorState extends AuthStates {}
class EnterCodeVerificationSuccessState extends AuthStates {}
class EnterCodeVerificationLoadingState extends AuthStates {}


class CheckCodeLoadingState extends AuthStates {}

class CheckCodeSuccessState extends AuthStates {}

class CheckCodeErrorState extends AuthStates {}

class AppleSignInLoadingState extends AuthStates {}
class AppleSignInSuccessState extends AuthStates {}
class AppleSignInErrorState extends AuthStates {}
