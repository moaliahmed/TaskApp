import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../blocs/task_model/cubit/task_model_cubit.dart';
import '../components/task_conpoment.dart';

class ViewCalenderScreen extends StatefulWidget {
  const ViewCalenderScreen({super.key});

  @override
  State<ViewCalenderScreen> createState() => _ViewCalenderScreenState();
}

class _ViewCalenderScreenState extends State<ViewCalenderScreen> {
  var _controller = CalendarController();
  late String daySelected;
  late DateTime startTime;
  late DateTime endTime;
  DateTime? selsted = DateTime.now();
ScrollController controller=ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TableCalendar(
                  initialCalendarFormat: CalendarFormat.week,
                  calendarStyle: CalendarStyle(
                      canEventMarkersOverflow: true,
                      todayColor: Colors.orange,
                      selectedColor: Theme.of(context).primaryColor,
                      todayStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white)),
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonDecoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    formatButtonTextStyle: const TextStyle(color: Colors.white),
                    formatButtonShowsNext: false,
                  ),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: (date, events, holidays) {
                    setState(() {
                      selsted = date;
                    });
                    print(selsted);
                  },
                  builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          daySelected = date.day.toString(),
                          style: const TextStyle(color: Colors.white),
                        )),
                    todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  calendarController: _controller,
                ),
                BlocConsumer<TaskModelCubit, TaskModelState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                            var cubit = TaskModelCubit.get(context);
          
            
                          return
                       cubit.jGetTask==null? const LinearProgressIndicator():
                      
                     ListView.builder(
                      controller: controller,
                       shrinkWrap: true,
                       physics: BouncingScrollPhysics(),
                       itemCount: cubit.jGetTask!.response!.length,
                       itemBuilder: (context, index) {
          
                         startTime = DateTime.parse(
                             '${cubit.jGetTask!.response![index].startDate}');
                         endTime = DateTime.parse(
                             '${cubit.jGetTask!.response![index].endDate}');
                         return selsted!.day >= startTime.day &&
                                 selsted!.month >= startTime.month &&
                                 selsted!.year >= startTime.year &&
                                 selsted!.day <= endTime.day &&
                                 selsted!.month <= endTime.month &&
                                 selsted!.year <= endTime.year
                             ? TasksContainer(
                                 posation: 'calender',
                                 image: cubit.jGetTask!.response![index].image,
                                 discription:
                                     cubit.jGetTask!.response![index].description,
                                 startDate:
                                     cubit.jGetTask!.response![index].startDate,
                                 endDate: cubit.jGetTask!.response![index].endDate,
                                 status: cubit.jGetTask!.response![index].status,
                                 title: cubit.jGetTask!.response![index].title,
                                 id: cubit.jGetTask!.response![index].id)
                             : Container();
                       },
                     );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
