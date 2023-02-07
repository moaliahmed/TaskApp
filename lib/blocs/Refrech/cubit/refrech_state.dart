part of 'refrech_cubit.dart';

@immutable
abstract class RefrechState {}

class RefrechInitial extends RefrechState {}


class RefrechSuccsessState extends RefrechState {}

class RefrechErrorState extends RefrechState {}

class RefrechLoadingState extends RefrechState {}
