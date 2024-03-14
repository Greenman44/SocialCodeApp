import 'package:social_code_app/features/messaging/domain/entitties/message.dart';
import 'package:social_code_app/features/messaging/domain/repository/message_repository.dart';

class MessageStreamer {
  IMessagingRepository repository;
  MessageStreamer({required this.repository});

  Stream<List<Message>> call({void params}) {
    return repository.messageYielder;
  }
}
