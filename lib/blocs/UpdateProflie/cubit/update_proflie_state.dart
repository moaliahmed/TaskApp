part of 'update_proflie_cubit.dart';

@immutable
abstract class UpdateProflieState {}

class UpdateProflieInitial extends UpdateProflieState {}
class UpdateProflieLoadingState extends UpdateProflieState {}

class UpdateProflieSuccsessState extends UpdateProflieState {}

class UpdateProflieErrorState extends UpdateProflieState {}
