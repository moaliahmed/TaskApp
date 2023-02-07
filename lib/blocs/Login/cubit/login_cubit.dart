import 'package:finelproject/models/auth.dart';
import 'package:finelproject/services/dio_helper.dart';
import 'package:finelproject/sharedPreferans/sharedPreferance.dart';
import 'package:finelproject/sharedPreferans/shared_preferans_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  TextEditingController passwordLogInController = TextEditingController();
  TextEditingController userLogInController = TextEditingController();

  TextEditingController userRegisterController = TextEditingController();
  TextEditingController nameRegisterController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();
  
  bool? prefs;
  Auth? jLogin;
  login() {
    emit(LoginLoding());
    DioHelper.postData(url: 'login', data: {
      'email': userLogInController.text,
      'password': passwordLogInController.text
    }).then((value) {
      emit(LoginSuccess());
      jLogin=Auth.fromJson(value.data!);
      SharedPrefrenceHelper.saveData(key: SPKeys.token, value: jLogin!.authorisation!.token);
      
      userLogInController.clear();
        passwordLogInController.clear();
        print(SharedPrefrenceHelper.getData(key: 'token'));
    }).catchError((e) {
      emit(LoginError());
      print(e);
    });
  }

register() {
    emit(RegisterLoding());
    DioHelper.postData(url: 'register', data: {
      "name": nameRegisterController.text,
      "email": userRegisterController.text,
      "password": passwordRegisterController.text,
      
    },
    ).then((value) {

      emit(RegisterSuccess());
          nameRegisterController.clear();
          userRegisterController.clear();
          passwordRegisterController.clear();

    }).catchError((onError) {
      print(onError.toString());
      emit(RegisterError());
    });
  }


  onbording ()async{
       bool? prefs =await SharedPrefrenceHelper.getData(key: 'onbording')??false;
       print(prefs);
  }
}
