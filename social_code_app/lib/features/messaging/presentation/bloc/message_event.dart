part of "message_bloc.dart";

abstract class MessageEvent {}

class PostMessageEvent extends MessageEvent {
  Message message;
  PostMessageEvent(this.message);
}

class DeleteMessageEvent extends MessageEvent {
  Message message;
  DeleteMessageEvent(this.message);
}

class PostUnPostLike extends MessageEvent {
  final Message message;
  final User user;

  PostUnPostLike(this.message, this.user);
}

class MessageChangedEvent extends MessageEvent {
  final List<Message> message;

  MessageChangedEvent(this.message);
}
