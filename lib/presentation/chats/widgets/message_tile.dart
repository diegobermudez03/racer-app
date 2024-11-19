import 'package:flutter/material.dart';
import 'package:racer_app/entities/message_entity.dart';

class MessageTile extends StatelessWidget {
  final MessageEntity message;

  const MessageTile({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isUserMessage = !message.othersMessage;
    final alignment = isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start;
    final bgColor = isUserMessage ? Colors.green[400] : Colors.blue[100];
    final textColor = isUserMessage ? colorScheme.onPrimaryContainer : colorScheme.onSurface;
    final margin = isUserMessage
        ? const EdgeInsets.only(left: 70, right: 16, top: 4, bottom: 4)
        : const EdgeInsets.only(right: 70, left: 16, top: 4, bottom: 4);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          Container(
            margin: margin,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: isUserMessage ? const Radius.circular(12) : const Radius.circular(0),
                bottomRight: isUserMessage ? const Radius.circular(0) : const Radius.circular(12),
              ),
            ),
            constraints: const BoxConstraints(maxWidth: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.content,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
