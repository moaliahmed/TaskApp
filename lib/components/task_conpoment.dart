import 'package:finelproject/appColors/app_color.dart';
import 'package:finelproject/blocs/generat_color/cubit/gnerate_color_cubit.dart';
import 'package:finelproject/blocs/task_model/cubit/task_model_cubit.dart';
import 'package:finelproject/components/my_text.dart';
import 'package:finelproject/enums/toast_states.dart';
import 'package:finelproject/screens/edit_task.dart';
import 'package:finelproject/utils/toast_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/task_detiles_screen.dart';
import '../utils/app_navigator.dart';

class TasksContainer extends StatefulWidget {
  String? title;
  String? discription;
  String? status;
  String? startDate;
  String? endDate;
  int? id;
  String? image;
  String posation;
  TasksContainer(
      {required this.discription,
      required this.startDate,
      required this.endDate,
      required this.status,
      required this.title,
      required this.image,
      required this.id,
      required this.posation
      });

  @override
  State<TasksContainer> createState() => _TasksContainerState();
}

class _TasksContainerState extends State<TasksContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GnerateColorCubit, GnerateColorState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = GnerateColorCubit.get(context);
           Color kmaincolor= cubit.colorsList[cubit.generateColor()!];
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                 print(widget.id);
                AppNavigator.appNavigator(context,false,TaskDetailsScreen(
                      image:widget.image,
                      color: kmaincolor,
                      id: widget.id!,
                      title: widget.title,
                      status: widget.status,
                      discription: widget.discription,
                      startDate: widget.startDate,
                      endDate: widget.endDate,
                      posation: widget.posation,
                    ));
              },
              child: Container(
                padding: EdgeInsets.all(16),
                width: 250.w,
                height: 250.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color:kmaincolor),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: 200.w,
                            child: MyText(
                              maxLines: 1,
                              color: AppColor.kWhiteColor,
                              text: widget.title ?? ' ',
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        MyText(
                          text: widget.status ?? '',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyText(
                            color: AppColor.kWhiteColor,
                            text: widget.discription ?? '',
                            maxLines: 5,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                     BlocConsumer<TaskModelCubit, TaskModelState>(
                      listener: (context, state) {
                       if (state is DeleteTaskSuccssess){
                        ToastConfig.showToast(msg: 'delete Success', toastStates: ToastStates.Success);
                        setState(() {
                          
                        });
                       }
                      },
                      builder: (context, state) {
                        var cubit =TaskModelCubit.get(context);
                        return    Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  print(widget.id);
                                  AppNavigator.appNavigator(context, false, EditTaskScreen(
                                  discription: widget.discription,
                                  startDate: widget.startDate, 
                                  endDate: widget.endDate,
                                   status: widget.status,
                                   title: widget.title,
                                    id: widget.id!));},
                                icon: Icon(
                                  Icons.edit,
                                  color: AppColor.kWhiteColor,
                                )),
                            IconButton(
                                onPressed: () {
                                  cubit.deleteTask(id: widget.id!);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: AppColor.kWhiteColor,
                                ))
                          ],
                        );
                      
                      },
                     )],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    const Divider(
                      endIndent: 60,
                      indent: 10,
                      color: Colors.black,
                      thickness: 3,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.alarm,
                          color: AppColor.kWhiteColor,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        MyText(
                          color: AppColor.kWhiteColor,
                          text: widget.startDate ?? '',
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        MyText(
                          color: AppColor.kWhiteColor,
                          text: widget.endDate ?? '',
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp,
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
