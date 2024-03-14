import 'package:social_code_app/core/usecase/usecase.dart';
import 'package:social_code_app/features/messaging/domain/entitties/message.dart';
import 'package:social_code_app/features/messaging/domain/repository/message_repository.dart';
import 'package:social_code_app/shared/domain/entitites/user.dart';

class UserLikesMessage extends Usecase<bool, Map<String, dynamic>> {
  final IMessagingRepository repository;

  UserLikesMessage({required this.repository});

  @override
  Future<bool> call({Map<String, dynamic>? params}) async {
    if (params != null) {
      Message message = params["message"]! as Message;
      User user = params["user"]! as User;
      return repository.userLikesMessage(message, user);
    }
    throw Exception("wrong params");
  }
}
