import 'package:social_code_app/shared/domain/entitites/user.dart';

class FirestoreUser extends User {
  FirestoreUser({required super.id, super.name, super.email, super.photoUrl});

  factory FirestoreUser.fromFirestore(Map<String, dynamic> user) {
    return FirestoreUser(
        id: user["id"],
        name: user["name"],
        email: user["email"],
        photoUrl: user["photoUrl"]);
  }
  static Map<String, dynamic> toFirestoreFormat(User user) {
    return <String, dynamic>{
      "id": user.id,
      "name": user.name,
      "photoUrl": user.photoUrl,
      "email": user.email
    };
  }
}
