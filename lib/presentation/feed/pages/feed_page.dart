import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/core/app_strings.dart';
import 'package:racer_app/core/custom_navigator.dart';
import 'package:racer_app/presentation/chats/controller/chats_bloc.dart';
import 'package:racer_app/presentation/feed/controller/feed_bloc.dart';
import 'package:racer_app/presentation/feed/controller/feed_state.dart';

class FeedPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _printHeader(context),
        BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
          return SizedBox();
        },)
      ],
    );
  }

  Row _printHeader(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: ()=> CustomNavigator.goToSearchPage(context), 
          label: const Text(AppStrings.search),
          icon: const Icon(Icons.search),
        ),
        const Text(AppStrings.appName),
        ElevatedButton.icon(
          onPressed: ()=> CustomNavigator.goToChatsPage(context), 
          label: const Text(AppStrings.chats),
          icon: const Icon(Icons.chat),
        ),
      ],
    );
  }
}