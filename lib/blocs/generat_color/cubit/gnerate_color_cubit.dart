import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'gnerate_color_state.dart';

class GnerateColorCubit extends Cubit<GnerateColorState> {
  GnerateColorCubit() : super(GnerateColorInitial());
  static GnerateColorCubit get(context) => BlocProvider.of(context);
  Random random = Random();
  int? index;
  List colorsList = [
   Color(0xffcec7ff),
   Color(0xfff6c6d8),
   Color(0xffa1ffb7)
  ];
  generateColor() {
    index = random.nextInt(colorsList.length);
    return index;
  }
}
