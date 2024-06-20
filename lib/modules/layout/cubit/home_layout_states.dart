

import '../../../models/user_data_model.dart';

abstract class HomeLayoutStates {}

class AppInitialStates extends HomeLayoutStates {}


class HomeLoadingStates extends HomeLayoutStates {}
class HomeSuccessStates extends HomeLayoutStates {}
class HomeErrorStates extends HomeLayoutStates {}



class ChangeBottomNavState extends HomeLayoutStates {}

//  get User Data
class GetUserDataLoadingState extends HomeLayoutStates {}
class GetUserDataSuccessState extends HomeLayoutStates {
  final UserDataModel userData;
  GetUserDataSuccessState({required this.userData});
}
class GetUserDataErrorState extends HomeLayoutStates {}

//  Change Password
class ChangePasswordLoadingState extends HomeLayoutStates {}

class ChangePasswordSuccessState extends HomeLayoutStates {}

class ChangePasswordErrorState extends HomeLayoutStates {}

