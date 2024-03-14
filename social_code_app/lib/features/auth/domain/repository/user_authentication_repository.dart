import 'package:social_code_app/shared/domain/entitites/user.dart';

abstract class IUserAuthenticationRepository {
  Stream<User> get user;
  Future<void> signUp({required String email, required String password});
  Future<void> logInWithGoogle();
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password});
  Future<void> logOut();
  Future<void> updateUser({required Map<String, dynamic> newParams});
  Future<void> deleteUser(String userEmail);
}
