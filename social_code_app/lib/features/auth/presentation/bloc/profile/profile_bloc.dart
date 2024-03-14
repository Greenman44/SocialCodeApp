import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_code_app/features/auth/domain/repository/photo_loader_repository.dart';
import 'package:social_code_app/features/auth/domain/repository/user_authentication_repository.dart';

part 'profile_event.dart';
part "profile_state.dart";

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IUserAuthenticationRepository userAuth;
  final IPhotoUpLoaderRepository photoUp;
  ProfileBloc({required this.userAuth, required this.photoUp})
      : super(InitialProfileState()) {
    on<UploadPhotoEvent>(_uploadPhoto);
    on<NameChangingEvent>(_nameChanging);
    on<NameChangedEvent>(_nameChanged);
  }

  FutureOr<void> _uploadPhoto(
      UploadPhotoEvent event, Emitter<ProfileState> emit) async {
    try {
      var imageUrl = await photoUp.uploadPhoto(event.email);
      if (imageUrl != null) {
        await userAuth.updateUser(newParams: {"photoUrl": imageUrl});
        emit(PhotoChangedState());
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  FutureOr<void> _nameChanging(
      NameChangingEvent event, Emitter<ProfileState> emit) {}

  FutureOr<void> _nameChanged(
      NameChangedEvent event, Emitter<ProfileState> emit) {}
}
