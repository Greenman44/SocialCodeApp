part of "profile_bloc.dart";

abstract class ProfileState {}

class FetchingImageState extends ProfileState {
  final String? url;
  FetchingImageState({required this.url});
}

class PhotoChangedState extends ProfileState {}

class ChangingNameState extends ProfileState {}

class NameChangedState extends ProfileState {}

class InitialProfileState extends ProfileState {}

class ProfileError extends ProfileState {
  String errorMessage;
  ProfileError(this.errorMessage);
}
