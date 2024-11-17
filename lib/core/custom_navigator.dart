import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:racer_app/core/main_page/home_page.dart';
import 'package:racer_app/presentation/auth/controller/auth_blocs.dart';
import 'package:racer_app/presentation/auth/pages/register_page.dart';
import 'package:racer_app/presentation/chats/controller/chats_bloc.dart';
import 'package:racer_app/presentation/chats/pages/chats_page.dart';
import 'package:racer_app/presentation/search/controller/search_bloc.dart';
import 'package:racer_app/presentation/search/pages/search_page.dart';

class CustomNavigator{
  static void goToHomepage(BuildContext context){
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (con)=> HomePage())
    ); 
  }

  static void goToRegisterPage(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (con)=> BlocProvider(
          create: (c)=>GetIt.instance.get<RegisterBloc>(),
          child: RegisterPage(),
        )
      )
    );
  }

  static void goToChatsPage(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (con)=> BlocProvider(
          create: (c)=>GetIt.instance.get<ChatsBloc>(),
          child: ChatsPage(),
        )
      )
    );
  }

  static void goToSearchPage(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (con)=> BlocProvider(
          create: (c)=>GetIt.instance.get<SearchBloc>(),
          child: SearchPage(),
        )
      )
    );
  }
}