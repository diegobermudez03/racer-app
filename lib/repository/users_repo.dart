import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:racer_app/entities/user_entity.dart';
import 'package:racer_app/repository/auth_repo.dart';

abstract class UsersRepo{
  Future<Tuple2<String?, List<Tuple2<UserEntity, String>>?>> searchUsers(String text);
}


class UsersRepoImpl implements UsersRepo{

  final DatabaseReference database;
  final FirebaseStorage storage;

  UsersRepoImpl(
    this.database,
    this.storage
  );
  
  @override
  Future<Tuple2<String?, List<Tuple2<UserEntity, String>>?>> searchUsers(String text) async {
    try {
      final DataSnapshot snapshot = await database.child('users').get();
      final Map<dynamic, dynamic>? usersMap = snapshot.value as Map<dynamic, dynamic>?;
      if (usersMap == null) {
        return const Tuple2("No users found", null);
      }

      List<Tuple2<UserEntity, String>> matchingUsers = [];

      for (var entry in usersMap.entries) {
        final userId = entry.key as String;
        final userData = entry.value as Map<dynamic, dynamic>;
        final userName = userData['username'] as String? ?? '';

        if (userName.toLowerCase().contains(text.toLowerCase()) && userId != AuthRepoFirebase.currentUser!.id) {
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
          } catch (e) {}
        }
      }
      return Tuple2(null, matchingUsers);
    } catch (e) {
      return Tuple2(e.toString(), null);
    }
  }
  
}