import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:racer_app/entities/message_entity.dart';

abstract class ChatsRepo{
  Future<Tuple2<String?, Stream<MessageEntity>?>> getChat(String? chatId, String? otherUsersId);
  Future<Tuple2<String?, void>> sendMessage(String chatId, String content);
}

class ChatsRepoImpl implements ChatsRepo{

  final DatabaseReference database;
  final FirebaseAuth auth;

  ChatsRepoImpl(
    this.database, this.auth
  );

  @override
  Future<Tuple2<String?, Stream<MessageEntity>?>> getChat(String? chatId, String? otherUserId) async {
    try{
      final currentUserId = auth.currentUser!.uid;

      if (chatId == null) {
        DatabaseReference newChatRef = database.child('chats').push();
        chatId = newChatRef.key;

        await newChatRef.set({
          'user1id': currentUserId,
          'user2id': otherUserId,
          'messages': {}
        });
      }

      DatabaseReference messagesRef = database.child('chats/$chatId/messages');

      Stream<MessageEntity> messageStream = messagesRef.onChildAdded.map((event) {
        final messageData = event.snapshot.value as Map<dynamic, dynamic>;
        return MessageEntity(
          event.snapshot.key!,
          messageData['content'] as String? ?? '',
          messageData['senderid'] != currentUserId,
          DateTime.tryParse(messageData['sentdate'] as String? ?? '') ?? DateTime.now(),
        );
      });

      return Tuple2(null, messageStream);
    }catch(e){
      return Tuple2(e.toString(), null);
    }
  }

  @override
  Future<Tuple2<String?, void>> sendMessage(String chatId, String content)async {
    try{
      final currentUserId = auth.currentUser!.uid;

      DatabaseReference messagesRef = database.child('chats/$chatId/messages').push();
      await messagesRef.set({
        'senderid': currentUserId,
        'sentdate': DateTime.now().toIso8601String(),
        'content': content,
      });

      return Tuple2(null, null);
    }catch(e){
      return Tuple2(e.toString(), null);
    }
  }
  
}