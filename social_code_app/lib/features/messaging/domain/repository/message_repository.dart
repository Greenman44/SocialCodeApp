import 'package:social_code_app/features/messaging/domain/entitties/message.dart';
import 'package:social_code_app/shared/domain/entitites/user.dart';

abstract class IMessagingRepository {
  Future<void> uploadMessage(Message message);
  Stream<List<Message>> get messageYielder;
  Future<void> deleteMessage(Message message);
  bool userLikesMessage(Message message, User user);
  Future<void> likeDislikeMessage(Message message, User user);
  Stream<List<Message>> get mostPopularMessages;
}
