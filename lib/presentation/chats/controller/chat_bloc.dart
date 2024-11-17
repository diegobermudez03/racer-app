import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/presentation/chats/controller/chat_states.dart';

class ChatBloc extends Cubit<ChatState>{

  ChatBloc(): super(ChatInitialState());

  void getChat(String? chatId,String? otherUsersId)async{
  }


  void sendMessage(String content)async{
    
  }
}