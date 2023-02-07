part of 'task_model_cubit.dart';

@immutable
abstract class TaskModelState {}

class TaskModelInitial extends TaskModelState {}


class GetTaskSuccess extends TaskModelState {}
class GetTaskLoding extends TaskModelState {}
class GetTaskError extends TaskModelState {}


class AddTaskSuccess extends TaskModelState {}
class AddTaskLoding extends TaskModelState {}
class AddTaskError extends TaskModelState {}


class DeleteTaskSuccssess extends TaskModelState {}
class DeleteTaskError extends TaskModelState {}
class DeleteTaskLoding extends TaskModelState {}

