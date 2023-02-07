import 'package:bloc/bloc.dart';
import 'package:finelproject/sharedPreferans/shared_preferans_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../services/dio_helper.dart';
import '../../../sharedPreferans/sharedPreferance.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());
   TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  static ChangePasswordCubit get(context) => BlocProvider.of(context);
  changePassword() {
    emit(ChangePasswordLoadingState());
    DioHelper.postData(
            url: 'change-password',
            data: {
              'password': newPassword.text,
              'confirm_password': confirmNewPassword.text
            },
            token:
                SharedPrefrenceHelper.getData(key: SPKeys.token))
        .then((value) {
      print('Password Changed');
      emit(ChangePasswordSucssesState());
    }).catchError((error) {
      print('Error $error');
      emit(ChangePasswordErrorState());
    });
  }
}
