import 'package:finelproject/appColors/app_color.dart';
import 'package:finelproject/blocs/generat_color/cubit/gnerate_color_cubit.dart';
import 'package:finelproject/blocs/task_model/cubit/task_model_cubit.dart';
import 'package:finelproject/components/my_text.dart';
import 'package:finelproject/screens/edit_task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/task_detiles_screen.dart';
import '../utils/app_navigator.dart';

class TasksContainer extends StatelessWidget {
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
                 print(id);
                AppNavigator.appNavigator(context,false,TaskDetailsScreen(
                      image:image,
                      color: kmaincolor,
                      id: id!,
                      title: title,
                      status: status,
                      discription: discription,
                      startDate: startDate,
                      endDate: endDate,
                      posation: posation,
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
                              text: title ?? ' ',
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        MyText(
                          text: status ?? '',
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
                            text: discription ?? '',
                            maxLines: 5,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                     BlocConsumer<TaskModelCubit, TaskModelState>(
                      listener: (context, state) {
                       
                      },
                      builder: (context, state) {
                        var cubit =TaskModelCubit.get(context);
                        return    Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  print(id);
                                  AppNavigator.appNavigator(context, false, EditTaskScreen(
                                  discription: discription,
                                  startDate: startDate, 
                                  endDate: endDate,
                                   status: status,
                                   title: title,
                                    id: id!));},
                                icon: Icon(
                                  Icons.edit,
                                  color: AppColor.kWhiteColor,
                                )),
                            IconButton(
                                onPressed: () {
                                  cubit.deleteTask(id: id!);
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
                      color: Colors.white,
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
                          text: startDate ?? '',
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        MyText(
                          color: AppColor.kWhiteColor,
                          text: endDate ?? '',
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
