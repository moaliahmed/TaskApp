import 'package:finelproject/blocs/task_model/cubit/task_model_cubit.dart';
import 'package:finelproject/screens/view_stats.dart';
import 'package:finelproject/utils/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/task_conpoment.dart';
import 'home_screen.dart';

class ViewCalenderScreen extends StatefulWidget {
  const ViewCalenderScreen({super.key});

  @override
  State<ViewCalenderScreen> createState() => _ViewCalenderScreenState();
}

class _ViewCalenderScreenState extends State<ViewCalenderScreen> {

   void initState() {
    TaskModelCubit.get(context).getTask();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var _controller = CalendarController();
    late String daySelected;

    DateTime? selsted = DateTime.now();
    var events = {};
    return BlocConsumer<TaskModelCubit, TaskModelState>(
      listener: (context, state) {
       
      },
      builder: (context, state) {
        var cubit =TaskModelCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              AppNavigator.appNavigator(context, true, HomeScreen());
            }, icon: Icon(Icons.arrow_back_rounded)),
            backgroundColor: Colors.indigo[50],
          ),


          body: SingleChildScrollView(
            child: Column(children: [
              TableCalendar(
                initialCalendarFormat: CalendarFormat.week,
                calendarStyle: CalendarStyle(
                    canEventMarkersOverflow: true,
                    todayColor: Colors.orange,
                    selectedColor: Theme.of(context).primaryColor,
                    todayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white)),
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  formatButtonShowsNext: false,
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: (date, events, holidays) {
                  selsted = date;
                },
                 builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                       daySelected= date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                  todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                calendarController: _controller,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row( mainAxisAlignment: MainAxisAlignment.end,
                
                  children: [
                    IconButton(onPressed: (){  print('$daySelected');}, icon: Icon(Icons.refresh)),
                    IconButton( icon: Icon(Icons.list_alt), onPressed: (){AppNavigator.appNavigator(context, false, ViewStateScreen());},)],),
              ),
              Column(
                     children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: cubit.jGetTask!.response!.length,
                        itemBuilder: (context, index) {
                         
                          return TasksContainer(
                            posation: 'calender',
                              image: cubit.jGetTask!.response![index].image,
                              discription: cubit.jGetTask!.response![index].description,
                              startDate: cubit.jGetTask!.response![index].startDate,
                              endDate: cubit.jGetTask!.response![index].endDate,
                              status: cubit.jGetTask!.response![index].status,
                              title: cubit.jGetTask!.response![index].title,
                              id: cubit.jGetTask!.response![index].id);
                        },
                      ),]
                   ),
            ]),
          ),
        );
      },
    );
  }
}
