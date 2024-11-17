import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/entities/message_entity.dart';
import 'package:racer_app/presentation/chats/controller/chat_bloc.dart';
import 'package:racer_app/presentation/chats/controller/chat_states.dart';

class ChatPage extends StatelessWidget{
  
  final controller = TextEditingController();
  final String? chatId;
  final String? otherUsersId;

  ChatPage({
    super.key,
    this.chatId,
    this.otherUsersId
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _printAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<ChatBloc, ChatState>(builder: (context, state){
              final provider = BlocProvider.of<ChatBloc>(context);
              if(state is ChatInitialState){
                provider.getChat(chatId, otherUsersId);
              }
              return switch(state){
                ChatRetrievingState() => Center(child: CircularProgressIndicator(),),
                ChatRetrievedState(messages: final messages) => _printChats(messages),
                ChatState() => SizedBox(),
              };
            }),
            Row(
              children: [
                TextField(
                  controller: controller,
                  onSubmitted: _sendMessage,
                ),
                IconButton(
                  onPressed: ()=>_sendMessage(controller.text), 
                  icon: Icon(Icons.send),
                )
              ],
            )
          ],
        )
      ),
    );
  }

  Column _printChats(List<MessageEntity> mesages){
    return Column();
  }
  

  void _sendMessage(String text){

  }

  AppBar _printAppBar(){
    return AppBar();
  }
}