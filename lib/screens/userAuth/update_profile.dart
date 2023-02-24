import 'package:finelproject/components/my_button.dart';
import 'package:finelproject/components/my_text_field.dart';
import 'package:finelproject/enums/toast_states.dart';
import 'package:finelproject/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../appColors/app_color.dart';
import '../../blocs/UpdateProflie/cubit/update_proflie_cubit.dart';
import '../../utils/app_navigator.dart';
import '../../utils/toast_config.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
       leading: IconButton(color: Colors.black,
        onPressed: (){AppNavigator.appNavigator(context, true, HomeScreen());}, icon: Icon(Icons.arrow_back_rounded)),
        title: Text(
           'Update Profile',
           style: TextStyle( 
          fontSize: 24.sp,
          color: AppColor.kBlack,
          fontWeight: FontWeight.bold,
        ),)
      ),
      body: BlocProvider(
        create: (context) => UpdateProflieCubit(),
        child: BlocConsumer<UpdateProflieCubit, UpdateProflieState>(
          listener: (context, state) {
            if (state is UpdateProflieSuccsessState) {
              ToastConfig.showToast(
                  msg: 'Updated', toastStates: ToastStates.Success);
              AppNavigator.appNavigator(context, true, HomeScreen());
            }
          },
          builder: (context, state) {
            var cubit = UpdateProflieCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyTextFiled(
                      label: 'Name',
                      controller: cubit.nameController,
                     ),
                     SizedBox(height: 40,),
                  MyButton(
                    colorContainer: AppColor.kBlack,
                    
                    width: 320,
                    
                    buttonName: 'Update',
                    function: () {
                      cubit.updateProfile();
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
