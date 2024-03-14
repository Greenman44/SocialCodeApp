import 'package:social_code_app/core/usecase/usecase.dart';
import 'package:social_code_app/shared/domain/repository/user_status.dart';

class UserLogOut extends Usecase<void, void> {
  final IUserStatus status;

  UserLogOut({required this.status});
  @override
  Future<void> call({void params}) async {
    return await status.userLogOut();
  }
}
