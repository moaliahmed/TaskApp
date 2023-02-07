import 'package:finelproject/appColors/app_color.dart';
import 'package:finelproject/blocs/ChangePassword/cubit/change_password_cubit.dart';
import 'package:finelproject/blocs/Edit_Task/cubit/edit_task_cubit.dart';
import 'package:finelproject/blocs/Login/cubit/login_cubit.dart';
import 'package:finelproject/blocs/Logout/cubit/logout_cubit.dart';
import 'package:finelproject/blocs/UpdateProflie/cubit/update_proflie_cubit.dart';
import 'package:finelproject/blocs/task_model/cubit/task_model_cubit.dart';
import 'package:finelproject/screens/login_screen.dart';
import 'package:finelproject/screens/on_bording_screen.dart';
import 'package:finelproject/screens/view_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../blocs/generat_color/cubit/gnerate_color_cubit.dart';
import '../sharedPreferans/sharedPreferance.dart';

class AppRoot extends StatelessWidget {
   AppRoot({super.key,});
   bool? prefs;
   
  @override
  
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginCubit(),
            ),
            BlocProvider(
              create: (context) => TaskModelCubit(),
            ),
            BlocProvider(
              create: (context) => GnerateColorCubit(),
            ),
            BlocProvider(
              create: (context) => EditTaskCubit(),
            ),
            BlocProvider(
              create: (context) => UpdateProflieCubit(),
            ),
            BlocProvider(
              create: (context) => ChangePasswordCubit(),
            ),
            BlocProvider(
              create: (context) => LogoutCubit(),
            ),
          ],
          child: MaterialApp (
            
            theme: ThemeData(
              primaryColor: AppColor.kDeepOrange
              

            ),
            home: LoginScreen(),
          ),
        );
      },
    );
  }
}
