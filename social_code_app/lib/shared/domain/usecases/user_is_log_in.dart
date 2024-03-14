import 'package:social_code_app/core/usecase/usecase.dart';
import 'package:social_code_app/shared/domain/repository/user_status.dart';

class UserIsLogin extends Usecase<Stream<bool>, void> {
  final IUserStatus status;
  UserIsLogin({required this.status});
  @override
  Future<Stream<bool>> call({void params}) async {
    return status.logInStatus;
  }
}
