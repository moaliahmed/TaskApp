import 'package:finelproject/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';

import 'services/dio_helper.dart';
import 'sharedPreferans/sharedPreferance.dart';
import 'sharedPreferans/shared_preferans_keys.dart';
import 'src/app_root.dart';

main(){
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
 SharedPrefrenceHelper.init();


  runApp(AppRoot());
}