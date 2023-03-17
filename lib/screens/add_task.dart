
import 'dart:io';

import 'package:finelproject/appColors/app_color.dart';
import 'package:finelproject/components/button_Time.dart';
import 'package:finelproject/components/my_button.dart';
import 'package:finelproject/components/my_text_field.dart';
import 'package:finelproject/screens/home_screen.dart';
import 'package:finelproject/screens/task_detiles_screen.dart';
import 'package:finelproject/utils/app_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import '../blocs/task_model/cubit/task_model_cubit.dart';
import '../enums/toast_states.dart';
import '../utils/toast_config.dart';

class AddTaskScreen extends StatefulWidget {
   AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final recorder =FlutterSoundRecorder();
  bool isRecorderReady =false;
  @override
  void initState() {
    initRecorder();
    super.initState();
  }
  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder()async{
    final status =await Permission.microphone.request();

    if (status!=PermissionStatus.granted){
      throw 'mictophone permission not granted';
    }
    await recorder.openRecorder();
    isRecorderReady =true;
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }


  Future record()async{
    if(!isRecorderReady)return ;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop()async{
    if(!isRecorderReady)return;
   final path = await recorder.stopRecorder();
   final audioFile = File(path!);
   print('recorded audio : $audioFile');

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskModelCubit, TaskModelState>(
      listener: (context, state) {
         if(state is AddTaskSuccess){
          ToastConfig.showToast(msg: 'Success', toastStates: ToastStates.Success); 
          AppNavigator.appNavigator(context, false, HomeScreen());
          }
      },
      builder: (context, state) {
        var cubit = TaskModelCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.indigo[50],
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orangeAccent,
            onPressed: (){
            cubit.addTask();
            print('click');
          },child: Icon(Icons.add)),
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
                      MyTextFiled(label: '', controller: cubit.TitelController),
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
                        controller: cubit.DiscriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.redAccent))),
                      ),
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
                      label: '*End Time',
                      controller: cubit.endTime,
                    )
                  ],
                ),
                SizedBox(height: 10,), Divider(
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '*Reminder',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColor.kmainColor)),
                            onPressed: () async {
                              cubit.ReminderTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  
                                  );
                                  
                            },
                            child: Text(
                              'Show Time Reminder',
                              style: TextStyle(fontSize: 20),
                            )),
                      )
                    ],
                  ),
                ), Divider(
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('*Attach',style: TextStyle(fontSize: 20),),
                      TextButton(onPressed: ()async{
                        if (recorder.isRecording){
                          await stop();
                        }else {
                          await record();
                        }

                      }, child: Row(
                        children: [
                          Icon(recorder.isRecording ? Icons.stop : Icons.mic,color: AppColor.kmainColor,),
                          Text('record voice',style: TextStyle(color: AppColor.kmainColor,fontSize: 18),),SizedBox(width: 90,),
                          StreamBuilder<RecordingDisposition>(
                            stream: recorder.onProgress,
                            builder: (context, snapshot) {
                            final duration =snapshot.hasData?snapshot.data!.duration:Duration.zero;
                            String twoDigits(int n)=>n.toString().padLeft(n);
                            final twoDigitMinutes =twoDigits(duration.inMinutes.remainder(60));
                            final twoDigitSeconds =twoDigits(duration.inSeconds.remainder(60));
                            return Text( '$twoDigitMinutes : $twoDigitSeconds',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.orangeAccent ),);
                          },)
                        ],
                      ) ),
                    
                      TextButton(
                        
                        onPressed: (){}, child: Row(
                        children: [
                          Icon(Icons.image,color: AppColor.kmainColor,),
                          Text('Add Image',style: TextStyle(color: AppColor.kmainColor,fontSize: 18),),
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
