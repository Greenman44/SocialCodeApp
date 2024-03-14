// ignore_for_file: library_prefixes

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_code_app/core/error/login_errors.dart';
import 'package:social_code_app/shared/data/models/user_from_firebase.dart';
import 'package:social_code_app/shared/domain/entitites/user.dart' as myUser;
import 'package:social_code_app/features/auth/domain/repository/user_authentication_repository.dart';

class IFirebaseAuthenticationRepository extends IUserAuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.standard();
  @override
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> logInWithGoogle() async {
    try {
      late final AuthCredential credential;

      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw const LogOutFailure();
    }
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Stream<myUser.User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null
          ? myUser.User.empty
          : FirebaseUserModel.fromFirebase(firebaseUser);
      return user;
    });
  }

  @override
  Future<void> deleteUser(String userEmail) async {
    User? user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception("Something went wrong trying to delete your account");
    } else {
      try {
        await user.delete();
      } on FirebaseAuthException catch (e) {
        if (e.code == "requires-recent.login") {
          logOut();
          throw (Exception(
              "You need to sign in before you can delete your account"));
        }
      } catch (e) {
        rethrow;
      }
    }
  }

  @override
  Future<void> updateUser({required Map<String, dynamic> newParams}) async {
    User? user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception("Something went wrong, sign up again");
    } else {
      if (newParams.containsKey("name")) {
        await user.updateDisplayName(newParams["name"]);
      }
      if (newParams.containsKey("photoUrl")) {
        await user.updatePhotoURL(newParams["photoUrl"]);
      }
    }
  }
}
