import 'package:social_code_app/core/usecase/usecase.dart';
import 'package:social_code_app/features/messaging/domain/entitties/message.dart';
import 'package:social_code_app/features/messaging/domain/repository/message_repository.dart';

class DeleteMessages extends Usecase<void, Message> {
  IMessagingRepository repository;
  DeleteMessages({required this.repository});
  @override
  Future<void> call({Message? params}) async {
    return await repository.deleteMessage(params!);
  }
}
