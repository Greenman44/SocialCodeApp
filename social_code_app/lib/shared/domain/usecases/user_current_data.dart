import 'package:social_code_app/core/usecase/usecase.dart';
import 'package:social_code_app/shared/domain/entitites/user.dart';
import 'package:social_code_app/shared/domain/repository/user_status.dart';

class UserCurrentData extends Usecase<User, void> {
  final IUserStatus status;

  UserCurrentData({required this.status});

  @override
  Future<User> call({void params}) async {
    return status.getCurrentUserData();
  }
}
