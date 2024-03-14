import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_code_app/core/error/login_errors.dart';
// ignore: library_prefixes
import 'package:social_code_app/shared/domain/entitites/user.dart' as myUser;
import 'package:social_code_app/shared/domain/repository/user_status.dart';

class FirebaseUserStatus extends IUserStatus {
  @override
  myUser.User getCurrentUserData() {
    if (FirebaseAuth.instance.currentUser != null) {
      var user = FirebaseAuth.instance.currentUser!;
      return myUser.User(
          id: user.uid,
          email: user.email,
          name: user.displayName,
          photoUrl: user.photoURL);
    }
    return myUser.User.empty;
  }

  @override
  Stream<bool> get logInStatus {
    return FirebaseAuth.instance.authStateChanges().map((user) => user != null);
  }

  @override
  Future<void> userLogOut() async {
    try {
      await Future.wait([
        FirebaseAuth.instance.signOut(),
        GoogleSignIn().signOut(),
      ]);
    } catch (_) {
      throw const LogOutFailure();
    }
  }
}
