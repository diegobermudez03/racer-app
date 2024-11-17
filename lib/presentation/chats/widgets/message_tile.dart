import 'package:flutter/material.dart';
import 'package:racer_app/entities/message_entity.dart';

class MessageTile extends StatelessWidget{
  
  final MessageEntity message;

  MessageTile({
    super.key,
    required this.message
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: message.othersMessage ? MainAxisAlignment.start :MainAxisAlignment.end ,
        children: [
          Container(
            color: message.othersMessage ? Colors.green[50] : Colors.blue[50],
            margin: message.othersMessage ? EdgeInsets.only(right: 70) : EdgeInsets.only(left: 70),
            child: Column(
              children: [
                Text(message.content),
                Text('${message.date.hour.toString().padLeft(2, '0')}:${message.date.minute.toString().padLeft(2, '0')}'),
              ],
            ),
          ),
        ],
      ),
    );
  }



}