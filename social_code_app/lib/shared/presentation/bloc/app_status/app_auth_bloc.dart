import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_code_app/shared/domain/shared_domain.dart';
part 'app_auth_event_events.dart';
part 'app_auth_status_states.dart';

class AppAuthBloc extends Bloc<AppAuthEvent, AppState> {
  final UserIsLogin login;
  final UserLogOut logOut;
  final UserCurrentData currentData;
  late final StreamSubscription<bool> _userSubscription;
  AppAuthBloc(
      {required this.login, required this.logOut, required this.currentData})
      : super(const AppState.unauthenticated()) {
    on<_AppUserChange>(_onUserChanged);
    on<AppLogOutRequest>(_onLogoutRequested);
    _userSubscription = login.status.logInStatus.listen(
        (user) => add(_AppUserChange(currentData.status.getCurrentUserData())));
  }

  _onUserChanged(_AppUserChange event, Emitter<AppState> emit) {
    emit(
      event.user.id.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  _onLogoutRequested(AppLogOutRequest event, Emitter<AppState> emit) {
    unawaited(logOut.call());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
