part of "login_bloc.dart";

abstract class LoginState {}

class SignInLoading extends LoginState {}

class FillingInfo extends LoginState {}

class GoogleLoading extends LoginState {}

class LoginErrorMessage extends LoginState {
  LoginErrorMessage(this.error);
  final String error;
}
