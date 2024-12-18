import 'package:racer_app/entities/message_entity.dart';

abstract class ChatState{}

class ChatInitialState implements ChatState{}

class ChatRetrievingState implements ChatState{}

class CharFailureState implements ChatState{
  String message;
  CharFailureState(this.message);
}

class ChatRetrievedState implements ChatState{
  final List<MessageEntity> messages;
  final String? chatId;

  ChatRetrievedState(this.messages, this.chatId);
}