import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo{
  Future<Tuple2<String?, bool?>> login(String email, String password);
}


class AuthRepoFirebase implements AuthRepo{

  final firebase = FirebaseAuth.instance;

  Future<Tuple2<String?, bool?>> login(String email, String password)async{
    try{
      final res = await firebase.signInWithEmailAndPassword(email: email, password: password);
      return const Tuple2(null, true);
    }catch(err){
      return Tuple2(err.toString(), null);
    }
  }
}