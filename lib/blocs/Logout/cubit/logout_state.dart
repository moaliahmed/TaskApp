part of 'logout_cubit.dart';

@immutable
abstract class LogoutState {}

class LogoutInitial extends LogoutState {}




class LogoutSuccess extends LogoutState {}
class LogoutLoding extends LogoutState {}
class LogoutError extends LogoutState {}
