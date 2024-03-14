import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_code_app/features/messaging/domain/entitties/likes.dart';
import 'package:social_code_app/features/messaging/domain/entitties/message.dart';
import 'package:social_code_app/features/messaging/domain/entitties/message_chunk.dart';
import 'package:social_code_app/shared/data/models/user_from_firestore.dart';

class FirestoreMessage extends Message {
  FirestoreMessage(
      {required super.chunks,
      required super.user,
      required super.jumps,
      required super.timeStamp,
      required super.likes});
  factory FirestoreMessage.fromFirestore(Map<String, dynamic> message) {
    List<Like> likes = (message["likes"] as List<dynamic>)
        .map((e) => Like(userEmail: e.toString()))
        .toList();
    List<int> jumps =
        (message["jumps"] as List<dynamic>).map((e) => int.parse(e)).toList();
    List<MessageChunk> chunks = [];
    for (var chunk in (message["chunks"] as Map<String, dynamic>).keys) {
      var currentchunk = message["chunks"][chunk];
      chunks.add(MessageChunk(
          chunk: currentchunk["text"], language: currentchunk["language"]));
    }
    return FirestoreMessage(
        chunks: chunks,
        user: FirestoreUser.fromFirestore(message["user"]),
        jumps: jumps,
        timeStamp: (message["timestamp"] as Timestamp).toDate(),
        likes: likes);
  }
  static Map<String, dynamic> toFirestoreFormat(Message message) {
    List<String> likes = message.likes.map((e) => e.userEmail).toList();
    int count = 0;
    Map<String, dynamic> chunks = {};
    for (var chunk in message.chunks) {
      chunks[count.toString()] = <String, dynamic>{
        "text": chunk.chunk,
        "language": chunk.language
      };
      count++;
    }
    return <String, dynamic>{
      "user": FirestoreUser.toFirestoreFormat(message.user),
      "chunks": chunks,
      "jumps": message.jumps,
      "timestamp": Timestamp.fromDate(message.timeStamp),
      "likes": likes
    };
  }
}

class FirestoreChunk extends MessageChunk {
  FirestoreChunk({required super.chunk, required super.language});

  factory FirestoreChunk.fromFirestore(Map<String, dynamic> chunk) {
    return FirestoreChunk(chunk: chunk["text"], language: chunk["language"]);
  }
}
