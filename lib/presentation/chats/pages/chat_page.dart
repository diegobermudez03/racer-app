import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/entities/message_entity.dart';
import 'package:racer_app/presentation/chats/controller/chat_bloc.dart';
import 'package:racer_app/presentation/chats/controller/chat_states.dart';
import 'package:racer_app/presentation/chats/widgets/message_tile.dart';

class ChatPage extends StatefulWidget {
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: _printAppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Chat Content
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
                final provider = BlocProvider.of<ChatBloc>(context);
                if (state is ChatInitialState) {
                  provider.getChat(widget.chatId, widget.otherUsersId);
                }
                return switch (state) {
                  ChatRetrievingState() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  ChatRetrievedState(messages: final messages) => _printChats(messages),
                  CharFailureState(message: final mes) => Center(
                    child: Text(
                      mes,
                      style: TextStyle(
                        color: colorScheme.error,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ChatState() => const SizedBox(),
                };
              }),
            ),
            // Message Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Row(
                children: [
                  // Message TextField
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: colorScheme.outlineVariant,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller: controller,
                          onSubmitted: !sending && hasContent ? (val) => _sendMessage(val, context) : null,
                          onChanged: (val) {
                            setState(() {
                              hasContent = val.isNotEmpty;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Send Button
                  IconButton(
                    onPressed: !sending && hasContent ? () => _sendMessage(controller.text, context) : null,
                    icon: Icon(
                      Icons.send,
                      color: hasContent ? colorScheme.primary : colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _printChats(List<MessageEntity> messages) {
    sending = false;
    return SingleChildScrollView(
      reverse: true,
      child: Column(
        children: messages.map((m) => MessageTile(message: m)).toList(),
      ),
    );
  }

  void _sendMessage(String text, BuildContext context) {
    sending = true;
    controller.clear();
    BlocProvider.of<ChatBloc>(context).sendMessage(text);
  }

  AppBar _printAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      elevation: 1,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(widget.otherUsersPicUrl),
        ),
      ),
      title: Text(
        'Chat',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
