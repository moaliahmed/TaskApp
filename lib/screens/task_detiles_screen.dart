import 'package:action_slider/action_slider.dart';
import 'package:finelproject/screens/view_calender.dart';
import 'package:finelproject/screens/view_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../appColors/app_color.dart';
import '../blocs/Edit_Task/cubit/edit_task_cubit.dart';
import '../components/my_text.dart';
import '../enums/toast_states.dart';
import '../utils/app_navigator.dart';
import '../utils/toast_config.dart';

class TaskDetailsScreen extends StatelessWidget {
  String? posation;
  String? title;
  String? image;
  String? discription;
  String? status;
  String? startDate;
  String? endDate;
  Color?color;
   int id;
  TaskDetailsScreen(
      {required this.posation,
        required this.discription,
      required this.startDate,
      required this.endDate,
      required this.status,
      required this.title,
      required this.id,
      required this.image,
      required this.color
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: color??Colors.white,
            appBar: AppBar( 
              elevation: 0,
              backgroundColor: color??Colors.white,
              centerTitle: true,
              leading: IconButton(icon: Icon(Icons.arrow_back_rounded),onPressed: () {
               posation=='calender'?AppNavigator.appNavigator(context, true, ViewCalenderScreen()):
               AppNavigator.appNavigator(context, true, ViewStateScreen());
              },),
              title: MyText(
                text:  title ??'Null',
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
                color: AppColor.kWhiteColor,
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration : BoxDecoration(color: AppColor.kBlack,borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        width: 120.w,
                        height: 40.h,
                        child: status!=null ? Text('$status',style: TextStyle(color: AppColor.kWhiteColor,fontSize: 22.sp),):Text('null',style: TextStyle(color: AppColor.kWhiteColor,fontSize: 18.sp)) ,
                        ),
                    SizedBox(
                      height: 20.h,
                    ),
                    MyText(
                      text: discription ?? 'Null',
                      fontSize: 50.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        MyText(
                          text: 'Start Date',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w300,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        MyText(
                            text: startDate ??
                                'Null'),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        MyText(
                          text: 'End Date',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w300,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        MyText(
                            text:
                                endDate ?? 'Null'),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: 'Voice',
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.play_arrow),
                          color: AppColor.kWhiteColor,
                          iconSize: 40.sp,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: 200.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              image: image!=null ? NetworkImage('$image'):NetworkImage('https://img.freepik.com/free-vector/clipboard-with-check-list_1284-4368.jpg'),
                              fit: BoxFit.fill)),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                     
                    BlocConsumer<EditTaskCubit, EditTaskState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        var editCubit = EditTaskCubit.get(context);
                        return ActionSlider.standard(
                          action: (controller) {
                            editCubit.EditTask(
                                id: id ,
                                myState: 'completed',
                                description:
                                    discription??
                                        '',
                                endDate:
                                    endDate ?? '',
                                startDate:
                                    startDate ?? '',
                                title: title ?? ''
                                );
                            ToastConfig.showToast(
                                msg: 'Done', toastStates: ToastStates.Success);
                          },
                          child: MyText(
                            text: 'Set as Complete !',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          toggleColor: color,
                          backgroundColor: AppColor.kBlack,
                          icon: Icon(Icons.done),
                          height: 60.h,
                        );
                      },
                    ) 

                  ],
                ),
              ),
            ),
          );
       
  }
}
