import 'package:social_code_app/core/usecase/usecase.dart';
import 'package:social_code_app/shared/domain/entitites/user.dart';
import 'package:social_code_app/features/auth/domain/repository/user_authentication_repository.dart';

class GetUser extends Usecase<Stream<User>, void> {
  GetUser({required this.repository});
  final IUserAuthenticationRepository repository;
  @override
  Future<Stream<User>> call({void params}) async {
    return repository.user;
  }
}
