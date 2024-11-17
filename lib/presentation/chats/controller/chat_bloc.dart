import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/entities/message_entity.dart';
import 'package:racer_app/presentation/chats/controller/chat_states.dart';
import 'package:racer_app/repository/chat_repo.dart';

class ChatBloc extends Cubit<ChatState>{

  final ChatsRepo repo;

  ChatBloc(this.repo): super(ChatInitialState());

  void getChat(String? chatId,String? otherUsersId)async{
    await Future.delayed(Duration.zero);
    emit(ChatRetrievingState());
    final response = await repo.getChat(chatId, otherUsersId);
    if(response.value1 != null){
      emit(CharFailureState(response.value1!));
    }
    else{
      response.value2!.forEach((mes){
          final List<MessageEntity> messages = switch(state){
            ChatRetrievedState(messages: final mes) => mes,
            ChatState()=>[]
          };
          messages.add(mes);
          emit(ChatRetrievedState(messages, chatId));
        }
      );
    }
  }


  void sendMessage(String content){
    final String? chatId = switch(state){
      ChatRetrievedState(chatId: final id)=>id,
      ChatState() => null
    };
    if(chatId != null){
      repo.sendMessage(chatId, content);
    }
  }
}