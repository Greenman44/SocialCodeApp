part of "register_bloc.dart";

abstract class RegisterEvent {}

class SignUpAttempt extends RegisterEvent {
  SignUpAttempt(this.params);
  final LoginParams params;
}
