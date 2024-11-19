import 'package:flutter/material.dart';
import 'package:racer_app/core/app_strings.dart';
import 'package:racer_app/core/custom_navigator.dart';
import 'package:racer_app/presentation/feed/pages/feed_page.dart';

class MainFeedPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _printHeader(context),
        FeedPage(),
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