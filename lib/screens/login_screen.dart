import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:finelproject/appColors/app_color.dart';
import 'package:finelproject/blocs/Login/cubit/login_cubit.dart';
import 'package:finelproject/components/my_text_field.dart';
import 'package:finelproject/enums/toast_states.dart';
import 'package:finelproject/screens/home_screen.dart';
import 'package:finelproject/screens/register_screen.dart';
import 'package:finelproject/utils/app_navigator.dart';
import 'package:finelproject/utils/toast_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if(state is LoginSuccess){
          ToastConfig.showToast(msg: 'Success', toastStates: ToastStates.Success);
          AppNavigator.appNavigator(context, true, HomeScreen(userName: LoginCubit.get(context).jLogin!.user!.name,));
        }
        else if (state is LoginError){
          ToastConfig.showToast(msg: 'error', toastStates: ToastStates.Error);
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          backgroundColor: Color(0xffffffff),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/logo.jpg'),
               ToggleSwitch(
            minWidth: 90.0,
            cornerRadius: 20.0,
            activeBgColors: [[AppColor.kredColor], [AppColor.kmainColor]],
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.white,
            initialLabelIndex: 1,
            totalSwitches: 2,
            labels: ['Register', 'Login'],
            radiusStyle: true,
            onToggle: (index) {
              print('switched to: $index');
              if (index==0){
                AppNavigator.appNavigator(context, false, RegisterScreen());
              }
            },
          ),    SizedBox(
                  height: 400,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Color(0xfff2f2f2)),
                    child: Column(
                      
                      children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'sign in',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email Address'),
                            MyTextFiled(
                                label: 'Enter your Email', controller: cubit.userLogInController),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Password'),
                            MyTextFiled(
                                label: 'Enter your Password',
                                controller: cubit.passwordLogInController,
                                isPassword: true,
                                ),
                          ],
                        ),
                      ),
                      Container(
                
                          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                          width: double.infinity,
                          child: Text(
                            'Forget Password',
                            textAlign: TextAlign.right,
                          )),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          
                          style: ElevatedButton.styleFrom(backgroundColor: AppColor.kmainColor),
                          onPressed: () {
                            
                            cubit.login();
                          }, child: Text('Sign In',style: TextStyle(fontSize: 22),)),
                      )
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
