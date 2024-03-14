part of "register_bloc.dart";

abstract class RegisterState {}

class FillingRegisterInfo extends RegisterState {}

class SignUpMessageError extends RegisterState {
  SignUpMessageError(this.messageError);
  final String messageError;
}

class Loading extends RegisterState {}
