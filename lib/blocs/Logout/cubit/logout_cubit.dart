import 'package:bloc/bloc.dart';
import 'package:finelproject/services/dio_helper.dart';
import 'package:finelproject/sharedPreferans/sharedPreferance.dart';
import 'package:finelproject/sharedPreferans/shared_preferans_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());
  static LogoutCubit get(context) => BlocProvider.of(context);

  logout() {
    emit(LogoutLoding());
    DioHelper.postData(
            url: 'logout',
            data: {},
            token: SharedPrefrenceHelper.getData(key: SPKeys.token))
        .then((value) {
      print('suc');
      emit(LogoutSuccess());
    }).catchError((e) {
      emit(LogoutError());
      print('error$e');
    });
  }


  prnt(){
print('Done');
  }
}
