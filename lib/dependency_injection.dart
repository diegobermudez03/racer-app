import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:racer_app/presentation/auth/controller/auth_blocs.dart';
import 'package:racer_app/presentation/chats/controller/chat_bloc.dart';
import 'package:racer_app/presentation/chats/controller/chats_bloc.dart';
import 'package:racer_app/presentation/feed/controller/feed_bloc.dart';
import 'package:racer_app/presentation/search/controller/search_bloc.dart';
import 'package:racer_app/repository/auth_repo.dart';
import 'package:racer_app/repository/chat_repo.dart';
import 'package:racer_app/repository/map_repo.dart';
import 'package:racer_app/repository/users_repo.dart';

final inst = GetIt.instance;
final googleApiKey = 'AIzaSyCjonHDvRna94GF2Rjc9d7Uer4RlG8Isr8';

Future<void> initDependencies() async{
    //initialize firebase
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    //initializing databases
    final auth = FirebaseAuth.instance;
    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://taller3movil-f21bb-default-rtdb.firebaseio.com/'
    ).ref();
    final storage = FirebaseStorage.instanceFor(
      bucket: 'taller3movil-f21bb.appspot.com',
    );


    //register repos
    inst.registerLazySingleton<AuthRepo>(()=>AuthRepoFirebase(
      auth,  database, storage
    ));
    inst.registerLazySingleton<UsersRepo>(()=>UsersRepoImpl(
      database, storage
    ));
    inst.registerLazySingleton<ChatsRepo>(()=>ChatsRepoImpl(
      database, auth
    ));
    inst.registerLazySingleton<MapRepo>(()=>MapRepoImpl(
      googleApiKey
    ));


    //register blocs
    inst.registerFactory<LoginBloc>(()=>LoginBloc(inst.get()));
    inst.registerFactory<RegisterBloc>(()=>RegisterBloc(inst.get()));
    inst.registerFactory<FeedBloc>(()=>FeedBloc());
    inst.registerFactory<ChatsBloc>(()=>ChatsBloc());
    inst.registerFactory<SearchBloc>(()=>SearchBloc(inst.get()));
    inst.registerFactory<ChatBloc>(()=>ChatBloc(inst.get()));
}