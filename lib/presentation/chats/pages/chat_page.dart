import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/entities/message_entity.dart';
import 'package:racer_app/presentation/chats/controller/chat_bloc.dart';
import 'package:racer_app/presentation/chats/controller/chat_states.dart';
import 'package:racer_app/presentation/chats/widgets/message_tile.dart';

class ChatPage extends StatefulWidget{
  
  final String? chatId;
  final String? otherUsersId;
  final String otherUsersPicUrl;

  const ChatPage({
    super.key,
    this.chatId,
    this.otherUsersId,
    required this.otherUsersPicUrl,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();
  bool sending = false;
  bool hasContent = true;

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
                provider.getChat(widget.chatId, widget.otherUsersId);
              }
              return switch(state){
                ChatRetrievingState() => const Center(child: CircularProgressIndicator(),),
                ChatRetrievedState(messages: final messages) => _printChats(messages),
                CharFailureState(message: final mes)=> Center(child: Text(mes),),
                ChatState() => SizedBox(),
              };
            }),
            Row(
              children: [
                TextField(
                  controller: controller,
                  onSubmitted: !sending && hasContent ? (val)=>_sendMessage(val, context) : null,
                  onChanged: (val){
                    if(val.isEmpty){
                      setState(() {
                        hasContent = false;
                      });
                    }else{
                      if(!hasContent){
                        setState(() {
                          hasContent = true;
                        });
                      }
                    }
                  },
                ),
                IconButton(
                  onPressed: !sending && hasContent ? ()=>_sendMessage(controller.text, context) : null, 
                  icon: const Icon(Icons.send),
                )
              ],
            )
          ],
        )
      ),
    );
  }

  Widget _printChats(List<MessageEntity> mesages){
    sending = false;
    return SingleChildScrollView(
      child: Column(
        children: mesages.map((m)=>MessageTile(message: m)).toList(),
      ),
    );
  }

  void _sendMessage(String text, BuildContext context){
    sending = true;
    BlocProvider.of<ChatBloc>(context).sendMessage(text);
  }

  AppBar _printAppBar(){
    return AppBar(
      leading: CachedNetworkImage(
        width: 50,
        imageUrl: widget.otherUsersPicUrl
      ),
    );
  }
}