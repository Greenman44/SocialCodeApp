part of "profile_bloc.dart";

abstract class ProfileEvent {}

class UploadPhotoEvent extends ProfileEvent {
  final String email;
  UploadPhotoEvent(this.email);
}

class NameChangingEvent extends ProfileEvent {}

class NameChangedEvent extends ProfileEvent {}
