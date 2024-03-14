part of 'app_auth_bloc.dart';

sealed class AppAuthEvent {
  const AppAuthEvent();
}

final class AppLogOutRequest extends AppAuthEvent {
  const AppLogOutRequest();
}

final class _AppUserChange extends AppAuthEvent {
  const _AppUserChange(this.user);
  final User user;
}
