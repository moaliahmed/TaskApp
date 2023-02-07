import 'package:bloc/bloc.dart';
import 'package:finelproject/services/dio_helper.dart';
import 'package:finelproject/sharedPreferans/sharedPreferance.dart';
import 'package:finelproject/sharedPreferans/shared_preferans_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  EditTaskCubit() : super(EditTaskInitial());

  static EditTaskCubit get(context) => BlocProvider.of(context);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? startTime ;
  DateTime? endTime ;
  String? status ;
    DateTime now=DateTime.parse(DateTime.now().toString());

  var image;
       



  EditTask( {required int id,
    required  String? myState,
    required   String? title,
    required  String? description,
     required String? startDate,
    required String? endDate}) {
    emit(EditTaskLoding());
    DioHelper.postData(
      url: 'tasks/${id}',
       token:SharedPrefrenceHelper.getData(key: SPKeys.token),
      data:  {
        'title': title,
        'description': description,
        'start_date':startDate,
        'end_date': endDate,
        'status': myState,
        '_method': 'PUT',
        // 'image': File(imageFile!.path)
      },
    ).then((value) {
      print('suc $value');
      emit(EditTaskSuccess());
    }).catchError((e) {
      print('EditTaskError$e');
      emit(EditTaskError());
    });
  }
}
