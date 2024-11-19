import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:racer_app/entities/message_entity.dart';

abstract class ChatsRepo{
  Future<Tuple2<String?, String?>> checkChat(String otherUsersId);
  Future<Tuple2<String?, Stream<MessageEntity>?>> getChat(String chatId);
  Future<Tuple2<String?, void>> sendMessage(String chatId, String content);
}

class ChatsRepoImpl implements ChatsRepo{

  final DatabaseReference database;
  final FirebaseAuth auth;

  ChatsRepoImpl(
    this.database, this.auth
  );

  @override
  Future<Tuple2<String?, String?>> checkChat(String otherUsersId) async{
    try {
      final currentUserId = auth.currentUser!.uid;

      try{
        final snapshot = await database.child('chats').get();

        if (snapshot.exists) {
          final chats = snapshot.value as Map<dynamic, dynamic>;
          for (var entry in chats.entries) {
            final chatData = entry.value as Map<dynamic, dynamic>;
            if ((chatData['user1id'] == currentUserId && chatData['user2id'] == otherUsersId) ||
                (chatData['user1id'] == otherUsersId && chatData['user2id'] == currentUserId)) {
              return Tuple2(null, entry.key as String);
            }
          }
        }
      }catch(e){}

      DatabaseReference newChatRef = database.child('chats').push();
      final chatId = newChatRef.key!;
      await newChatRef.set({
        'user1id': currentUserId,
        'user2id': otherUsersId,
        'messages': {}
      });

      return Tuple2(null, chatId);
    } catch (e) {
      return Tuple2(e.toString(), null);
    }
  }


  @override
  Future<Tuple2<String?, Stream<MessageEntity>?>> getChat(String chatId) async {
    try{
      final currentUserId = auth.currentUser!.uid;

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

      return const Tuple2(null, null);
    }catch(e){
      return Tuple2(e.toString(), null);
    }
  }
  
}