// ignore_for_file: library_prefixes
import 'package:social_code_app/shared/domain/entitites/user.dart';

abstract class IUserStatus {
  Stream<bool> get logInStatus;
  User getCurrentUserData();
  Future<void> userLogOut();
}

// class UserStatusService {
//   final IUserStatus status;
//   UserStatusService({required this.status});

//   Stream<bool> isLogIn() {
//     return status.logInStatus;
//   }

//   Future<void> userLogOut() async {
//     return await status.userLogOut();
//   }

//   User currentUserData() {
//     return status.getCurrentUserData();
//   }
// }
