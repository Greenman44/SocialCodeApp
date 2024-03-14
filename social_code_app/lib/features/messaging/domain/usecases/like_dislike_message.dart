import 'package:social_code_app/core/usecase/usecase.dart';
import 'package:social_code_app/features/messaging/domain/entitties/message.dart';
import 'package:social_code_app/features/messaging/domain/repository/message_repository.dart';
import 'package:social_code_app/shared/domain/entitites/user.dart';

class LikeDislikeMessage extends Usecase<void, Map<String, dynamic>> {
  final IMessagingRepository repository;

  LikeDislikeMessage({required this.repository});
  @override
  Future<void> call({Map<String, dynamic>? params}) async {
    Message message = params!["message"] as Message;
    User user = params["user"] as User;
    return await repository.likeDislikeMessage(message, user);
  }
}
