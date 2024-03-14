import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:social_code_app/shared/domain/entitites/user.dart';

class FirebaseUserModel extends User {
  FirebaseUserModel({required super.id, super.email, super.photoUrl});
  factory FirebaseUserModel.fromFirebase(auth.User user) {
    return FirebaseUserModel(
        id: user.uid, photoUrl: user.photoURL, email: user.email);
  }
}
