import 'package:bloc/bloc.dart';
import 'package:finelproject/sharedPreferans/shared_preferans_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../services/dio_helper.dart';
import '../../../sharedPreferans/sharedPreferance.dart';

part 'update_proflie_state.dart';

class UpdateProflieCubit extends Cubit<UpdateProflieState> {
  UpdateProflieCubit() : super(UpdateProflieInitial());
 static UpdateProflieCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();
  
  updateProfile() {
    emit(UpdateProflieLoadingState());
    DioHelper.postData(
      url: 'update-profile',
      token: SharedPrefrenceHelper.getData(key: SPKeys.token),
      data: {'name': nameController.text},
    ).then((value) {
      emit(UpdateProflieSuccsessState());
      print('Suc');
    }).catchError((error) {
      print("Error $error");
      emit(UpdateProflieErrorState());
    });
  }


}
