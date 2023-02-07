part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}


class LoginSuccess extends LoginState {}
class LoginLoding extends LoginState {}
class LoginError extends LoginState {}


class RegisterSuccess extends LoginState {}
class RegisterLoding extends LoginState {}
class RegisterError extends LoginState {}