import 'package:finelproject/blocs/task_model/cubit/task_model_cubit.dart';
import 'package:finelproject/components/my_button.dart';
import 'package:finelproject/components/sound_playing.dart';
import 'package:finelproject/components/task_conpoment.dart';
import 'package:finelproject/screens/home_screen.dart';
import 'package:finelproject/screens/view_calender.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/app_navigator.dart';

class ViewStateScreen extends StatefulWidget {
  ViewStateScreen({super.key});
  String statu = 'all';
  @override
  State<ViewStateScreen> createState() => _ViewStateScreenState();
}

class _ViewStateScreenState extends State<ViewStateScreen> {
  void initState() {
    TaskModelCubit.get(context).getTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskModelCubit, TaskModelState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TaskModelCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  AppNavigator.appNavigator(context, true, HomeScreen());
                },
                icon: Icon(Icons.arrow_back_rounded)),
            backgroundColor: Colors.indigo[50],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      MyButton(
                        active: widget.statu == 'all' ? true : false,
                        buttonName: 'all',
                        function: () {
                          widget.statu = 'all';
                          setState(() {});
                        },
                        width: 60,
                      ),
                      MyButton(
                          active: widget.statu == 'new' ? true : false,
                          buttonName: 'New',
                          function: () {
                            widget.statu = 'new';
                            setState(() {});
                          }),
                      MyButton(
                        active: widget.statu == 'in progress' ? true : false,
                        buttonName: 'in progress',
                        function: () {
                          widget.statu = 'in progress';
                          setState(() {});
                        },
                        width: 120,
                      ),
                      MyButton(
                        active: widget.statu == 'completed' ? true : false,
                        buttonName: 'Completed',
                        function: () {
                          widget.statu = 'completed';
                          setState(() {});
                        },
                        width: 120,
                      ),
                      MyButton(
                        active: widget.statu == 'out of deted' ? true : false,
                        buttonName: 'Out of deted',
                        function: () {
                          widget.statu = 'out of deted';
                          setState(() {});
                        },
                        width: 132,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            AppNavigator.appNavigator(
                                context, true, ViewStateScreen());
                          },
                          icon: Icon(Icons.refresh)),
                      IconButton(
                        icon: Icon(Icons.calendar_month_outlined),
                        onPressed: () {
                          AppNavigator.appNavigator(
                              context, false, ViewCalenderScreen());
                        },
                      )
                    ],
                  ),
                ),
                cubit.jGetTask!.response!.length == 0
                    ? Container()
                    : Column(children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: cubit.jGetTask!.response!.length,
                          itemBuilder: (context, index) {
                            return widget.statu ==
                                        cubit.jGetTask!.response![index]
                                            .status ||
                                    widget.statu == 'all'
                                ? TasksContainer(
                                    posation: 'state',
                                    image:
                                        cubit.jGetTask!.response![index].image,
                                    discription: cubit
                                        .jGetTask!.response![index].description,
                                    startDate: cubit
                                        .jGetTask!.response![index].startDate,
                                    endDate: cubit
                                        .jGetTask!.response![index].endDate,
                                    status:
                                        cubit.jGetTask!.response![index].status,
                                    title:
                                        cubit.jGetTask!.response![index].title,
                                    id: cubit.jGetTask!.response![index].id)
                                : Container();
                          },
                        ),
                      ]),
              ],
            ),
          ),
        );
      },
    );
  }
}
