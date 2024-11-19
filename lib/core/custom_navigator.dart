import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:racer_app/core/main_page/home_page.dart';
import 'package:racer_app/presentation/auth/controller/auth_blocs.dart';
import 'package:racer_app/presentation/auth/pages/register_page.dart';
import 'package:racer_app/presentation/chats/controller/chat_bloc.dart';
import 'package:racer_app/presentation/chats/controller/chats_bloc.dart';
import 'package:racer_app/presentation/chats/pages/chat_page.dart';
import 'package:racer_app/presentation/chats/pages/chats_page.dart';
import 'package:racer_app/presentation/search/controller/search_bloc.dart';
import 'package:racer_app/presentation/search/pages/search_page.dart';

class CustomNavigator{
  static void goToHomepage(BuildContext context){
    while(Navigator.of(context).canPop()){
      Navigator.of(context).pop();
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (con)=> HomePage())
    ); 
  }

  static void goToRegisterPage(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (con)=> BlocProvider(
          create: (c)=>GetIt.instance.get<RegisterBloc>(),
          child: const RegisterPage(),
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
          child: const SearchPage(),
        )
      )
    );
  }

  //if id is null, then we assume is ourselves, the user's profile
  static void goToUserPage(BuildContext context, String? id){

  }

  //ONLY one, id or otherUserId must be null, id is if the page is openned from the chats page, and otherUserId if its from the search page
  static void goToChatWithUser(BuildContext context, String? id, String? otherUserId, String otherUsersPic){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (con)=> BlocProvider(
          create: (c)=>GetIt.instance.get<ChatBloc>(),
          child: ChatPage(chatId: id, otherUsersId: otherUserId, otherUsersPicUrl: otherUsersPic,),
        )
      )
    );
  }
}