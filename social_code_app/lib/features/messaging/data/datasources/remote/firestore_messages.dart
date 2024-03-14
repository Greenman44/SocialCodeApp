import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_code_app/features/messaging/data/datasources/data_source.dart';
import 'package:social_code_app/features/messaging/data/models/firestore_message.dart';
import 'package:social_code_app/features/messaging/domain/entitties/message.dart';
import 'package:social_code_app/shared/domain/entitites/user.dart';

class FirestoreMessageDB extends MessageDatasource {
  final db = FirebaseFirestore.instance;
  @override
  Future<void> deleteMessage(Message message) async {
    try {
      await db
          .collection("messages")
          .doc(
              "${message.user.email}+${message.timeStamp.millisecondsSinceEpoch.toString()}")
          .delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Message> getMessage(Message message) {
    // TODO: implement getMessage
    throw UnimplementedError();
  }

  @override
  Stream<List<Message>> get messageYielder {
    return db
        .collection("messages")
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((event) {
      return event.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        return FirestoreMessage.fromFirestore(doc.data());
      }).toList();
    });
  }

  @override
  Future<void> postMessage(Message message) async {
    try {
      await db
          .collection("messages")
          .doc(
              "${message.user.email!}+${message.timeStamp.millisecondsSinceEpoch.toString()}")
          .set(FirestoreMessage.toFirestoreFormat(message));
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> postLike(Message message, User user) async {
    List<String> likes = message.likes.map((e) => e.userEmail).toList();
    likes.add(user.email!);
    try {
      await db
          .collection("messages")
          .doc(
              "${message.user.email!}+${message.timeStamp.millisecondsSinceEpoch.toString()}")
          .update({"likes": likes});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> removeLike(Message message, User user) async {
    List<String> likes = message.likes.map((e) => e.userEmail).toList();
    likes.removeWhere((email) => email == user.email!);
    try {
      await db
          .collection("messages")
          .doc(
              "${message.user.email!}+${message.timeStamp.millisecondsSinceEpoch.toString()}")
          .update({"likes": likes});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Stream<List<Message>> get popularMessageYielder {
    return db.collection("messages").snapshots().map((event) {
      List<Message> messages = [];
      for (var doc in event.docs) {
        messages.add(FirestoreMessage.fromFirestore(doc.data()));
      }
      messages.sort((x, y) {
        return x.likes.length.compareTo(y.likes.length);
      });
      List<Message> reverse = [];
      for (var i = 0; i < messages.length; i++) {
        reverse.add(messages[messages.length - 1 - i]);
      }
      return reverse;
    });
  }
}
