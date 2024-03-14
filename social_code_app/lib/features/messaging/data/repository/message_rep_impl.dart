import 'package:social_code_app/features/messaging/data/datasources/data_source.dart';
import 'package:social_code_app/features/messaging/domain/entitties/message.dart';
import 'package:social_code_app/features/messaging/domain/repository/message_repository.dart';
import 'package:social_code_app/shared/domain/entitites/user.dart';

class MessageRepImpl extends IMessagingRepository {
  final MessageDatasource db;
  MessageRepImpl({required this.db});
  @override
  Future<void> deleteMessage(Message message) async {
    await db.deleteMessage(message);
  }

  @override
  Stream<List<Message>> get messageYielder => db.messageYielder;

  @override
  Future<void> uploadMessage(Message message) async {
    return await db.postMessage(message);
  }

  @override
  Stream<List<Message>> get mostPopularMessages {
    return db.popularMessageYielder;
  }

  @override
  Future<void> likeDislikeMessage(Message message, User user) async {
    if (message.likes.indexWhere((like) => like.userEmail == user.email!) >
        -1) {
      return await db.removeLike(message, user);
    } else {
      return await db.postLike(message, user);
    }
  }

  @override
  bool userLikesMessage(Message message, User user) {
    if (message.likes.indexWhere((like) => like.userEmail == user.email!) >
        -1) {
      return true;
    }
    return false;
  }
}
