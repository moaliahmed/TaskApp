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
import '../../blocs/ChangePassword/cubit/change_password_cubit.dart';
import '../../components/my_text.dart';
import '../../utils/app_navigator.dart';
import '../../utils/toast_config.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.kWhiteColor,
       
        title: MyText(
          text: 'Change password',
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: AppColor.kBlack,
        ),
      ),
      body:BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordErrorState) {
              ToastConfig.showToast(
                  msg: 'Error', toastStates: ToastStates.Error);
            }
            if (state is ChangePasswordSucssesState) {
              ToastConfig.showToast(
                  msg: 'Done', toastStates: ToastStates.Success);
                  AppNavigator.appNavigator(context, true, HomeScreen());
             
            }
          },
          builder: (context, state) {
            var cubit = ChangePasswordCubit.get(context);
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    MyTextFiled(
                        isPassword: true,
                        label: 'New Passowrd',
                        controller: cubit.newPassword,
                        ),
                        SizedBox(height: 30,),
                    MyTextFiled(
                        isPassword: true,
                        label: 'Confirm New Passowrd',
                        controller: cubit.confirmNewPassword,
                        ),
                    SizedBox(
                      height: 20.h,
                    ),
                    MyButton(
                        function: () {
                          cubit.changePassword();
                        },
                       
                        width: double.infinity,
                        
                        buttonName: 'Submit '),
                  ],
                ),
              ),
            );
          },
        ),
      
    );
  }
}
