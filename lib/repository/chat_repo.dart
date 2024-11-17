import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:racer_app/entities/message_entity.dart';

abstract class ChatRepo{
  Future<Tuple2<String?, Stream<MessageEntity>?>> getChat(String? chatId, String? otherUsersId);
  Future<Tuple2<String?, void>> sendMessage(String chatId, String content);
}

class ChatRepoImpl implements ChatRepo{

  final DatabaseReference database;
  final FirebaseStorage storage;

  ChatRepoImpl(
    this.database,
    this.storage
  );

  @override
  Future<Tuple2<String?, Stream<MessageEntity>?>> getChat(String? chatId, String? otherUsersId) {
    // TODO: implement getChat
    throw UnimplementedError();
  }

  @override
  Future<Tuple2<String?, void>> sendMessage(String chatId, String content) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
  
}