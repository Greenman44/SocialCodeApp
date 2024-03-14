part of "message_bloc.dart";

abstract class MessageState {}

class BrowsingMessages extends MessageState {
  final List<Message> messages;
  BrowsingMessages({required this.messages});
}

class LikedPosted extends MessageState {}

class ErrorMessage extends MessageState {
  String errorMessage;
  ErrorMessage(this.errorMessage);
}

class MessageDeleted extends MessageState {}

class MessageAdded extends MessageState {}
