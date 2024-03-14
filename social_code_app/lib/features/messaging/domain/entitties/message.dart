import 'package:social_code_app/features/messaging/domain/entitties/likes.dart';
import 'package:social_code_app/features/messaging/domain/entitties/message_chunk.dart';
import 'package:social_code_app/shared/domain/entitites/user.dart';

class Message {
  final User user;
  final List<MessageChunk> chunks;
  final DateTime timeStamp;
  final List<int> jumps;
  final List<Like> likes;

  Message(
      {required this.chunks,
      required this.user,
      required this.jumps,
      required this.timeStamp,
      required this.likes});
}
