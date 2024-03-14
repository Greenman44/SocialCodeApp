import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_code_app/features/auth/domain/entities/login_params.dart';
import 'package:social_code_app/features/auth/domain/usecases/login_usecases.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LogInWithEmailAndPassword logInWithEmailAndPassword;
  final LogInWithGoogle logInWithGoogle;
  LoginBloc(
      {required this.logInWithEmailAndPassword, required this.logInWithGoogle})
      : super(FillingInfo()) {
    on<LoginAttempt>(_login);
    on<LoginGoogleAttempt>(_googleLogin);
  }

  _login(LoginAttempt event, Emitter<LoginState> emit) async {
    try {
      emit(SignInLoading());
      await logInWithEmailAndPassword.call(params: event.params);
      emit(FillingInfo());
    } catch (e) {
      emit(LoginErrorMessage(e.toString()));
      emit(FillingInfo());
    }
  }

  _googleLogin(LoginGoogleAttempt event, Emitter<LoginState> emit) async {
    try {
      emit(GoogleLoading());
      await logInWithGoogle.call();
    } catch (e) {
      emit(LoginErrorMessage(e.toString()));
      emit(FillingInfo());
    }
  }
}
