import 'package:social_code_app/core/usecase/usecase.dart';
import 'package:social_code_app/features/auth/domain/repository/user_authentication_repository.dart';

class LogOut extends Usecase<void, void> {
  LogOut({required this.repository});
  final IUserAuthenticationRepository repository;
  @override
  Future<void> call({void params}) async {
    return await repository.logOut();
  }
}
