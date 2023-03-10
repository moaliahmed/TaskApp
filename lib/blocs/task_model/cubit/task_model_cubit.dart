import 'package:bloc/bloc.dart';
import 'package:finelproject/models/get_task.dart';
import 'package:finelproject/services/dio_helper.dart';
import 'package:finelproject/sharedPreferans/shared_preferans_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/Refresh.dart';
import '../../../sharedPreferans/sharedPreferance.dart';

part 'task_model_state.dart';

class TaskModelCubit extends Cubit<TaskModelState> {
  TaskModelCubit() : super(TaskModelInitial());
  static TaskModelCubit get(context) => BlocProvider.of(context);
  GetTask? jGetTask;
  String? status;
  Refresh? refresh;
  TextEditingController TitelController = TextEditingController();
  TextEditingController DiscriptionController = TextEditingController();
  DateTime? startTime;
  DateTime? endTime;
  TimeOfDay? ReminderTime;

  double newCoutner = 0;
  double completedCoutner = 0;
  double inProgressCoutner = 0;
  double outOfDateCoutner = 0;
  double test = 1;
  DateTime now = DateTime.parse(DateTime.now().toString());

  void getTask() {
    emit(GetTaskLoding());
    DioHelper.getData(
            url: 'tasks', token: SharedPrefrenceHelper.getData(key: 'token'
            //'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3Rhc2tzLmVyYWFzb2Z0LmNvbS9hcGkvbG9naW4iLCJpYXQiOjE2NzcyMjc3NTIsImV4cCI6MTY3NzIzMTM1MiwibmJmIjoxNjc3MjI3NzUyLCJqdGkiOiJxODZxUGVEc09iUUpRd25pIiwic3ViIjoiOTUiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.Hgv4KrWIAoVFaMS79ocUBJMjQmyJSztXA-lBOVT38JM')
            ))
        .then((value) {
      emit(GetTaskSuccess());
      jGetTask = GetTask.fromJson(value.data);
      newCoutner = 0;
      completedCoutner = 0;
      inProgressCoutner = 0;

      for (int i = 0; i <= jGetTask!.response!.length - 1; i++) {
        if (jGetTask!.response![i].status == "new") {
          newCoutner += 1;
          test = newCoutner;
        } else if (jGetTask!.response![i].status == "completed") {
          completedCoutner += 1;
        } else if (jGetTask!.response![i].status == "in_progress") {
          inProgressCoutner += 1;
        }
      }
      print(jGetTask!.status);
    }).catchError((e) {
      emit(GetTaskError());
      print('errer $e');
    });
  }

  void addTask() {
    emit(AddTaskLoding());
    DioHelper.postData(
            url: 'tasks',
            data: {
              'title': TitelController.text,
              'description': DiscriptionController.text,
              'start_date': startTime != null
                  ? '${startTime?.year.toString()}/${startTime?.month.toString()}/${startTime?.day.toString()}'
                  : '${now.year}/${now.month}/${now.day}',
              'end_date':
                  '${endTime!.year.toString()}/${endTime!.month.toString()}/${endTime!.day.toString()}',
            },
            token: SharedPrefrenceHelper.getData(key: SPKeys.token))
        .then((value) {
      emit(AddTaskSuccess());
      TitelController.clear();
      DiscriptionController.clear();

      print('sucess');
    }).catchError((e) {
      emit(AddTaskError());
      print('error $e');
    });
  }

  deleteTask({required int id}) {
    emit(DeleteTaskLoding());
    DioHelper.deleteData(
            url: 'tasks/${id}',
            token: SharedPrefrenceHelper.getData(key: SPKeys.token))
        .then((value) {
      emit(DeleteTaskSuccssess());
    }).catchError((error) {
      print('Error $error');
      emit(DeleteTaskError());
    });
  }

  appRefresh() {
    DioHelper.postData(
            url: 'refresh',
            data: {

            },
            token: SharedPrefrenceHelper.getData(key: SPKeys.token))
        .then((value) {
          refresh=Refresh.fromJson(value.data);
          print('refresh suc');
        })
        .catchError((e) {print('refresh error');});
  }
}
