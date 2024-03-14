import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_code_app/features/auth/domain/entities/login_params.dart';
import 'package:social_code_app/features/auth/domain/usecases/login_usecases.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required this.signUp}) : super(FillingRegisterInfo()) {
    on<SignUpAttempt>(_trySignUp);
  }
  final SignUp signUp;

  _trySignUp(SignUpAttempt event, Emitter<RegisterState> emit) async {
    try {
      emit(Loading());
      await signUp.call(params: event.params);
      emit(FillingRegisterInfo());
    } catch (e) {
      emit(SignUpMessageError(e.toString()));
      emit(FillingRegisterInfo());
    }
  }
}
