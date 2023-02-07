part of 'edit_task_cubit.dart';

@immutable
abstract class EditTaskState {}

class EditTaskInitial extends EditTaskState {}


class EditTaskSuccess extends EditTaskState {}
class EditTaskLoding extends EditTaskState {}
class EditTaskError extends EditTaskState {}