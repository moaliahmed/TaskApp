import 'package:finelproject/blocs/Edit_Task/cubit/edit_task_cubit.dart';
import 'package:finelproject/components/button_Time.dart';
import 'package:finelproject/components/my_button.dart';
import 'package:finelproject/components/my_text_field.dart';
import 'package:finelproject/enums/toast_states.dart';
import 'package:finelproject/screens/view_stats.dart';
import 'package:finelproject/utils/toast_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../appColors/app_color.dart';
import '../blocs/task_model/cubit/task_model_cubit.dart';
import '../utils/app_navigator.dart';

class EditTaskScreen extends StatelessWidget {
  
  String? title;
  String? discription;
  String? status;
  String? startDate;
  String? endDate;
  int id;
   DateTime now=DateTime.parse(DateTime.now().toString());

  EditTaskScreen(
      {required this.discription,
      required this.startDate,
      required this.endDate,
      required this.status,
      required this.title,
      
      required this.id
      });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditTaskCubit, EditTaskState>(
      listener: (context, state) {
        if(state is EditTaskSuccess){
          ToastConfig.showToast(msg: 'done', toastStates: ToastStates.Success);
          AppNavigator.appNavigator(context, true, ViewStateScreen());
        }
      },
      builder: (context, state) {
        var cubit = EditTaskCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Edit Task',style: TextStyle(fontSize: 18),),
            backgroundColor: Colors.indigo[50],
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(onPressed: (){
            
            cubit.EditTask(
              myState: cubit.status,
              id: id,
              title: cubit.titleController.text==''?title:cubit.titleController.text,
              description: cubit.descriptionController.text==''?discription:cubit.descriptionController.text,
              startDate:  cubit.startTime!=null? '${cubit.startTime?.year.toString()}/${cubit.startTime?.month.toString()}/${cubit.startTime?.day.toString()}': startDate,
              endDate:  cubit.endTime!=null? '${cubit.endTime?.year.toString()}/${cubit.endTime?.month.toString()}/${cubit.endTime?.day.toString()}': endDate) ;
          },child: Icon(Icons.edit_outlined)),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TiTle',
                        style: TextStyle(fontSize: 22),
                      ),
                      MyTextFiled(label: '$title', controller: cubit.titleController),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discribtion',
                        style: TextStyle(fontSize: 22),
                      ),
                      TextField(
                        controller: cubit.descriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "$discription",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.orange))),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '* Status',
                            style: TextStyle(fontSize: 22),
                          ),SizedBox(width: 10,),
                          Container(
                        decoration : BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        width: 120.w,
                        height: 30.h,
                        child: status!=null ? Text('$status',style: TextStyle(color: Colors.white,fontSize: 22.sp),):Text('null',style: TextStyle(color: AppColor.kWhiteColor,fontSize: 18.sp)) ,
                        ),
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            MyButton(
                              buttonName: 'New',
                              function: () {cubit.status='new';
                              print(cubit.status);},
                              width: 120,
                            ),
                            MyButton(
                              buttonName: 'in progrecs',
                              function: () {cubit.status='in_progress';
                              print(cubit.status);},
                              width: 120,
                            ),
                            MyButton(
                              buttonName: 'Completed',
                              function: () {cubit.status='completed'; print(cubit.status);},
                              width: 120,
                            ),
                            MyButton(
                              buttonName: 'Cut deted',
                              function: () {cubit.status='cut_deted'; print(cubit.status);},
                              width: 120,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TimeButton(
                      con: 's',
                      label: '*Start Time',
                      controller: cubit.startTime,
                    ),
                    TimeButton(
                      con: 'e',
                      label: '*End Time',
                      controller: cubit.endTime,
                    )
                  ],
                ),
                
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('*Attach',style: TextStyle(fontSize: 20),),
                      TextButton(onPressed: (){}, child: Row(
                        children: [
                          Icon(Icons.keyboard_voice_outlined),
                          Text('record voice'),
                        ],
                      ) ),
                    
                      TextButton(onPressed: (){}, child: Row(
                        children: [
                          Icon(Icons.image),
                          Text('Add Image'),
                        ],
                      ) )
                    
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
