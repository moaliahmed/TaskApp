import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:finelproject/appColors/app_color.dart';
import 'package:finelproject/blocs/Login/cubit/login_cubit.dart';
import 'package:finelproject/components/my_text_field.dart';
import 'package:finelproject/screens/login_screen.dart';
import 'package:finelproject/screens/register_screen.dart';
import 'package:finelproject/utils/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../enums/toast_states.dart';
import '../utils/toast_config.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
         if(state is RegisterSuccess){
          ToastConfig.showToast(msg: 'Success', toastStates: ToastStates.Success);
          
        }
        else if (state is RegisterError){
          ToastConfig.showToast(msg: 'error', toastStates: ToastStates.Error);
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          backgroundColor: Color(0xffffffff),
          body: SingleChildScrollView(
            child: Column(
            
              children: [
                Image.asset('assets/logo.jpg'),
                ToggleSwitch(
                  minWidth: 90.0,
                  cornerRadius: 20.0,
                  activeBgColors: [
                    [AppColor.kredColor],
                    [AppColor.kmainColor]
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  initialLabelIndex: 0,
                  totalSwitches: 2,
                  labels: ['Register', 'Login'],
                  radiusStyle: true,
                  onToggle: (index) {
                    print('switched to: $index');
                    if (index == 1) {
                      AppNavigator.appNavigator(context, false, LoginScreen());
                    }
                  },
                ),
                SizedBox(
                  
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Color(0xfff2f2f2)),
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        ' Register',
                        style:
                            TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('name'),
                            MyTextFiled(
                                label: 'Enter your name',
                                controller: cubit.nameRegisterController),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email Address'),
                            MyTextFiled(
                                label: 'Enter your Email',
                                controller: cubit.userRegisterController),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Password'),
                            MyTextFiled(
                                label: 'Enter your Password',
                                controller: cubit.passwordRegisterController),
                          ],
                        ),
                      ),
                     
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.kredColor),
                            onPressed: () {
                              cubit.register();
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(fontSize: 22),
                            )),
                      ),
                      SizedBox(height: 15,)
                    ]),
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
