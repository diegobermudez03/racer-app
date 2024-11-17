import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:racer_app/presentation/auth/controller/auth_blocs.dart';
import 'package:racer_app/presentation/chats/pages/chats_page.dart';
import 'package:racer_app/presentation/feed/controller/feed_bloc.dart';
import 'package:racer_app/presentation/search/controller/search_bloc.dart';
import 'package:racer_app/repository/auth_repo.dart';
import 'package:racer_app/repository/general_repo.dart';

final inst = GetIt.instance;

Future<void> initDependencies() async{
    //initialize firebase
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    //initializing databases
    final firebase = FirebaseAuth.instance;
    final database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://taller3movil-f21bb-default-rtdb.firebaseio.com/'
    ).ref();
    final storage = FirebaseStorage.instanceFor(
      bucket: 'taller3movil-f21bb.appspot.com',
    );


    //register repos
    inst.registerLazySingleton<AuthRepo>(()=>AuthRepoFirebase(
      firebase,  database, storage
    ));
    inst.registerLazySingleton<GeneralRepo>(()=>GeneralRepoImpl(
      database, storage
    ));

    //register blocs
    inst.registerFactory<LoginBloc>(()=>LoginBloc(inst.get()));
    inst.registerFactory<RegisterBloc>(()=>RegisterBloc(inst.get()));
    inst.registerFactory<FeedBloc>(()=>FeedBloc());
    inst.registerFactory<ChatsPage>(()=>ChatsPage());
    inst.registerFactory<SearchBloc>(()=>SearchBloc(inst.get()));
}