import 'package:bloc/bloc.dart';
import 'package:finelproject/sharedPreferans/shared_preferans_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/Refresh.dart';
import '../../../services/dio_helper.dart';
import '../../../sharedPreferans/sharedPreferance.dart';

part 'refrech_state.dart';

class RefrechCubit extends Cubit<RefrechState> {
  RefrechCubit() : super(RefrechInitial());
    static RefrechCubit get(context) => BlocProvider.of(context);
  Refresh refrech = Refresh();
  userRefrech() {
    DioHelper.postData(
            url: 'refresh',
            data: {},
            token:
                SharedPrefrenceHelper.getData(key: SPKeys.token))
        .then((value) {
      refrech = Refresh.fromJson(value.data);
      emit(RefrechSuccsessState());
      print('suc');
    }).catchError((error) {
      emit(RefrechErrorState());
      print('error');
    });
  }

  refrechdate(){
    return refrech.user!.name;
  }
}
