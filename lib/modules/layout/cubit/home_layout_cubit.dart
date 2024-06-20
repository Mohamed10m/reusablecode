import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/change_password.dart';
import '../../../models/user_data_model.dart';
import '../../../shared/componants/app_constants.dart';
import '../../../shared/end_points/end_points.dart';
import '../../../shared/remote_data_source/remote_data_source.dart';

import 'home_layout_states.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(AppInitialStates());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;


  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  UserDataModel? userDataModel;

  void getUserData() async {
    emit(GetUserDataLoadingState());

    await DioHelper.getData(path: profile, token: token).then((value) {
      userDataModel = UserDataModel.fromJson(value.data);

      emit(GetUserDataSuccessState(userData: userDataModel!));
    }).catchError((error) {
      emit(GetUserDataErrorState());
    });
  }

  ChangePasswordModel? changePasswordModel;

  void changePassword({
    required String email,
    required int code,
    required String newPassword,
    required String newPasswordConfirmation,

  }) {
    emit(ChangePasswordLoadingState());

    DioHelper.postData(
      token: token,
      path: changePass,
      data: {
        'email': email,
        'code': code,
        'new_password':newPassword,
        'new_password_confirmation':newPasswordConfirmation,
      },

    ).then((value) {

      emit(ChangePasswordSuccessState());
    }).catchError((error) {
      emit(ChangePasswordErrorState());
    });
  }


}
