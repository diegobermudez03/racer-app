import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class AuthRepo{
  Future<Tuple2<String?, bool?>> login(String email, String password);
  Future<Tuple2<String?, bool?>> register(String email, String password, String userName, String fullName, int age, double height, double weight, Uint8List profilePic) ;
}


class AuthRepoFirebase implements AuthRepo{

  final FirebaseAuth firebase;
  final DatabaseReference database;
  final FirebaseStorage storage;

  AuthRepoFirebase(
    this.firebase,
    this.database,
    this.storage
  );

  @override
  Future<Tuple2<String?, bool?>> login(String email, String password)async{
    try{
      await firebase.signInWithEmailAndPassword(email: email, password: password);
      return const Tuple2(null, true);
    }catch(err){
      return Tuple2(err.toString(), null);
    }
  }
  
  @override
  Future<Tuple2<String?, bool?>> register(String email, String password, String userName, String fullName, int age, double height, double weight, Uint8List profilePic) async {
    try {
      final UserCredential res = await firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String userId = res.user!.uid;

      await database.child('users/$userId').set({
        'username': userName,
        'fullname': fullName,
        'age': age,
        'weight' : weight,
        'height' : height
      });

      final Reference profilePicRef = storage.ref().child('users/$userId/profile');
      await profilePicRef.putData(profilePic);

      return const Tuple2(null, true);
    } catch (err) {
      return Tuple2(err.toString(), null);
    }
  }
}