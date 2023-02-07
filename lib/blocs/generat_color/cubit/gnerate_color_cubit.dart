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
    Colors.amber,
    Colors.green,
    Colors.redAccent,
    Colors.blueAccent,
    Colors.blueGrey,
    Colors.pink,
    Colors.blue[800],
    Colors.cyan,
    Colors.brown
  ];
  generateColor() {
    index = random.nextInt(colorsList.length);
    return index;
  }
}
