import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_code_app/features/messaging/domain/domain.dart';

import '../../../../shared/shared.dart';

part "message_event.dart";
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final UpLoadMessage upLoadMessage;
  final MessageStreamer streamer;
  final DeleteMessages deleteMessages;
  final LikeDislikeMessage likePoster;
  final UserLikesMessage userLikesMessage;
  final PopularMessageStreamer populars;
  //late final StreamSubscription<bool> _userSubscription;

  MessageBloc(
      {required this.likePoster,
      required this.upLoadMessage,
      required this.streamer,
      required this.deleteMessages,
      required this.userLikesMessage,
      required this.populars})
      : super(BrowsingMessages(messages: [])) {
    on<PostMessageEvent>(_postMessage);
    on<DeleteMessageEvent>(_deleteMessage);
    on<PostUnPostLike>(_postUnpostLike);
    on<MessageChangedEvent>(_messageChanged);
    streamer.call().listen((messages) {
      add(MessageChangedEvent(messages));
    });
  }

  _postMessage(PostMessageEvent event, Emitter<MessageState> emit) async {
    try {
      await upLoadMessage.call(params: event.message);
      //emit(BrowsingMessages(messageStreamer: streamer.call()));
    } catch (e) {
      emit(ErrorMessage(e.toString()));
    }
  }

  _deleteMessage(DeleteMessageEvent event, Emitter<MessageState> emit) async {
    try {
      await deleteMessages.call(params: event.message);
      //await Future.delayed(const Duration(milliseconds: 300));
      //emit(MessageDeleted());
      //emit(BrowsingMessages(messageStreamer: streamer));
    } catch (e) {
      emit(ErrorMessage(e.toString()));
    }
  }

  _postUnpostLike(PostUnPostLike event, Emitter<MessageState> emit) async {
    try {
      await likePoster.call(params: <String, dynamic>{
        "message": event.message,
        "user": event.user
      });
      //emit(LikedPosted());
      //emit(BrowsingMessages(messageStreamer: streamer.call()));
    } catch (e) {
      emit(ErrorMessage(e.toString()));
    }
  }

  _messageChanged(MessageChangedEvent event, Emitter<MessageState> emit) {
    emit(BrowsingMessages(messages: event.message));
  }
}
