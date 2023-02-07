import 'package:finelproject/blocs/task_model/cubit/task_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeButton extends StatelessWidget {
   TimeButton({super.key,required this.label,required this.controller, this.con });
DateTime? controller ;
String label;
String? con;
 
  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<TaskModelCubit, TaskModelState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit =TaskModelCubit.get(context);
        
        return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,style: TextStyle(fontSize: 20),),
                   SizedBox(
                    height: 50,
                    width: 160,
                     child: ElevatedButton(
                      style: ButtonStyle(),
                                      onPressed: () async {
                                        controller =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1990),
                                                lastDate: DateTime(2030));
                                       con=='s'?cubit.startTime=controller:cubit.endTime=controller;  
   
                                      },
                                      
                                      child: Text('Date Picker',style: TextStyle(fontSize: 18),)),
                   ),
                                  
                                    
                ],
              );
              
      },
    );
  }
}