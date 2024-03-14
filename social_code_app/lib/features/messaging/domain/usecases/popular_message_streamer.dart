import 'package:social_code_app/core/usecase/usecase.dart';
import 'package:social_code_app/features/messaging/domain/entitties/message.dart';
import 'package:social_code_app/features/messaging/domain/repository/message_repository.dart';

class PopularMessageStreamer extends Usecase<Stream<List<Message>>, void> {
  final IMessagingRepository repository;

  PopularMessageStreamer({required this.repository});
  @override
  Future<Stream<List<Message>>> call({void params}) async {
    return repository.mostPopularMessages;
  }
}
