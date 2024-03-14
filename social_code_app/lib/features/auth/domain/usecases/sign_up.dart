import 'package:social_code_app/core/usecase/usecase.dart';
import 'package:social_code_app/features/auth/domain/entities/login_params.dart';
import 'package:social_code_app/features/auth/domain/repository/user_authentication_repository.dart';

class SignUp extends Usecase<void, LoginParams> {
  SignUp({required this.repository});
  final IUserAuthenticationRepository repository;

  @override
  Future<void> call({LoginParams? params}) async {
    return await repository.signUp(
        email: params!.email, password: params.password);
  }
}
