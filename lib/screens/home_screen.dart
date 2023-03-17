import 'package:finelproject/appColors/app_color.dart';
import 'package:finelproject/blocs/Logout/cubit/logout_cubit.dart';
import 'package:finelproject/blocs/Refrech/cubit/refrech_cubit.dart';
import 'package:finelproject/blocs/task_model/cubit/task_model_cubit.dart';
import 'package:finelproject/components/my_button.dart';
import 'package:finelproject/enums/toast_states.dart';
import 'package:finelproject/screens/add_task.dart';
import 'package:finelproject/screens/login_screen.dart';
import 'package:finelproject/screens/userAuth/change_password.dart';
import 'package:finelproject/screens/userAuth/update_profile.dart';
import 'package:finelproject/screens/view_calender.dart';
import 'package:finelproject/screens/view_stats.dart';
import 'package:finelproject/utils/app_navigator.dart';
import 'package:finelproject/utils/toast_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spline_chart/spline_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, });

  String? userNametoo;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    TaskModelCubit.get(context).appRefresh();
    TaskModelCubit.get(context).getTask();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "new": TaskModelCubit.get(context).newCoutner.toDouble(),
      "completed": TaskModelCubit.get(context).completedCoutner.toDouble(),
      "in_progress": TaskModelCubit.get(context).inProgressCoutner.toDouble(),
    };
    List<Color> colorList = [
      Color(0xffA62639),
      Color(0xff02CCC0),
      Color(0xff56494E),
    ];
    return BlocConsumer<TaskModelCubit, TaskModelState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TaskModelCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.kmainColor,
          ),
          body: cubit.refresh==null
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                SizedBox(width: 15,),
                                Text(
                                  'Morning ,',
                                  style: TextStyle(fontSize: 22),
                                ),
                                Text(' ${cubit.refresh?.user?.name}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              radius: 17,
                              backgroundImage: AssetImage('assets/man.jpg'),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '   ${cubit.jGetTask!.response!.length}',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              '  Tasks are Waiting For You ToDay .',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 14,
                          ),
                          Text(
                            '*My Chart ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 300,
                        child: PieChart(
                          dataMap: {
                            "new": TaskModelCubit.get(context)
                                .newCoutner
                                .toDouble(),
                            "completed": TaskModelCubit.get(context)
                                .completedCoutner
                                .toDouble(),
                            "in_progress": TaskModelCubit.get(context)
                                .inProgressCoutner
                                .toDouble(),
                          },
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32,
                          chartRadius: MediaQuery.of(context).size.width / 2.3,
                          colorList: colorList,
                          initialAngleInDegree: 0,
                          chartType: ChartType.ring,
                          ringStrokeWidth: 40,
                          centerText: "Task chart",
                          legendOptions: LegendOptions(
                            showLegendsInRow: false,
                            showLegends: true,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: false,
                            showChartValuesOutside: false,
                            decimalPlaces: 1,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 14,
                              ),
                              Text(
                                '*View Taskound With ',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MyButton(
                                  width: 130,
                                  buttonName: 'State',
                                  iconButton: Icon(Icons.list_alt),
                                  function: () {
                                    AppNavigator.appNavigator(
                                        context, false, ViewStateScreen());
                                  }),
                              MyButton(
                                  width: 130,
                                  buttonName: 'Calendar',
                                  iconButton: Icon(Icons.calendar_today),
                                  function: () {
                                    AppNavigator.appNavigator(
                                        context, false, ViewCalenderScreen());
                                  }),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: AppColor.kDeepOrange,
              onPressed: () {
                AppNavigator.appNavigator(context, false, AddTaskScreen());
              },
              child: Icon(Icons.add)),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 70,
                ),
                Container(
                  height: 178,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/man.jpg'),
                  ),
                ),
                ListTile(
                  title: const Text('Update Profile'),
                  onTap: () {
                    AppNavigator.appNavigator(
                        context, false, UpdateProfileScreen());
                  },
                ),
                ListTile(
                  title: const Text('Change Password'),
                  onTap: () {
                    AppNavigator.appNavigator(
                        context, false, ChangePasswordScreen());
                  },
                ),
                BlocConsumer<LogoutCubit, LogoutState>(
                  listener: (context, state) {
                    if (state is LogoutSuccess) {
                      ToastConfig.showToast(
                          msg: 'by by ...', toastStates: ToastStates.Warning);
                      AppNavigator.appNavigator(context, true, LoginScreen());
                    }
                  },
                  builder: (context, state) {
                    var cubit = LogoutCubit.get(context);
                    return ListTile(
                      title: const Text('Logout'),
                      onTap: () {
                        cubit.logout();
                      },
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
