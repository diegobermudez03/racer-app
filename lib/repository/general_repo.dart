import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:racer_app/entities/user_entity.dart';

abstract class GeneralRepo{
  Future<Tuple2<String?, List<Tuple2<UserEntity, String>>?>> searchUsers(String text);
}


class GeneralRepoImpl implements GeneralRepo{

  final DatabaseReference database;
  final FirebaseStorage storage;

  GeneralRepoImpl(
    this.database,
    this.storage
  );
  
  @override
  Future<Tuple2<String?, List<Tuple2<UserEntity, String>>?>> searchUsers(String text) async {
    try {
      final DataSnapshot snapshot = await database.child('users').get();
      if (!snapshot.exists) {
        return Tuple2("No users found", null);
      }
      final Map<dynamic, dynamic>? usersMap = snapshot.value as Map<dynamic, dynamic>?;
      if (usersMap == null) {
        return Tuple2("No users found", null);
      }

      List<Tuple2<UserEntity, String>> matchingUsers = [];

      for (var entry in usersMap.entries) {
        final userId = entry.key as String;
        final userData = entry.value as Map<dynamic, dynamic>;
        final userName = userData['userName'] as String? ?? '';

        if (userName.toLowerCase().contains(text.toLowerCase())) {
          try {
            final ref = storage.ref().child('users/$userId/profile');
            final String downloadUrl = await ref.getDownloadURL();

            final userEntity = UserEntity(
              userId, 
              userData['fullname'],
              userData['username'],
              userData['age'],
              userData['height'],
              userData['weight']
            );
            matchingUsers.add(Tuple2(userEntity, downloadUrl));
          } catch (e) {
          }
        }
      }
      return Tuple2(null, matchingUsers);
    } catch (e) {
      return Tuple2(e.toString(), null);
    }
  }
  
}