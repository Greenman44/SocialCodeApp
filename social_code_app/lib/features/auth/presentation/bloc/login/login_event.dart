part of "login_bloc.dart";

abstract class LoginEvent {}

class LoginAttempt extends LoginEvent {
  LoginAttempt(this.params);
  final LoginParams params;
}

class LoginGoogleAttempt extends LoginEvent {}
