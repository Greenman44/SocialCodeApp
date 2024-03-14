import 'package:social_code_app/features/messaging/domain/entitties/message.dart';
import 'package:social_code_app/shared/domain/entitites/user.dart';

abstract class MessageDatasource {
  Future<void> postMessage(Message message);
  Future<void> deleteMessage(Message message);
  Future<Message> getMessage(Message message);
  Stream<List<Message>> get messageYielder;
  Future<void> postLike(Message message, User user);
  Future<void> removeLike(Message message, User user);
  Stream<List<Message>> get popularMessageYielder;
}
