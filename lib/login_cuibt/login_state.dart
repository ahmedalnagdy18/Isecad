part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

class LoginPasswordVisibilityChanged extends LoginState {
  final bool isObscure;
  LoginPasswordVisibilityChanged(this.isObscure);
}
