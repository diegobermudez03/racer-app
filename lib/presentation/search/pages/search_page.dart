import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/core/app_strings.dart';
import 'package:racer_app/entities/user_entity.dart';
import 'package:racer_app/presentation/search/controller/search_bloc.dart';
import 'package:racer_app/presentation/search/controller/search_states.dart';
import 'package:racer_app/presentation/search/widgets/user_tile.dart';
import 'package:racer_app/presentation/utilities/custom_dialogs.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _printSearchBar(context),
          ToggleButtons(
            isSelected: isSelected,
            onPressed: (index) {
              setState(() {
                isSelected[index] = true;
                int other = index == 0 ? 1 : 0;
                isSelected[other] = false;
                _resetSearch(context);
              });
            },
            children:const [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(AppStrings.users),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(AppStrings.events),
              ),
            ],
          ),
          BlocListener<SearchBloc, SearchState>(
            listener: (context, state) {
              if(state is SearchFailureState){
                CustomDialogs.showFailureDialog(context, state.message);
              }
            },
            child: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
              return switch(state){
                SearchUsersSuccess(users: final usrs)=> _printResult(usrs, context),
                SearchEventsSuccess(events: final evnts) =>  _printResult(evnts, context),
                SearchLoadingState() => const Center(child: CircularProgressIndicator()),
                SearchState() => const SizedBox(),
              };
            }),
          )
        ],
      ),
    );
  }

  Widget _printResult<T>(List<dartz.Tuple2<T, String>> results, BuildContext context){
    if(results.isEmpty){
      return const Center(
        child: Text(AppStrings.noResults),
      );
    }
    return Column(
      children: results.map((tple){
        if(tple.value1 is UserEntity){
          return UserTile(
            user: tple.value1 as UserEntity, 
            profilePictureUrl: tple.value2, 
            onSeeUserPressed: ()=>_seeUser(context), 
            onChatPressed: ()=>_seeChatWithUser(context)
          );
        }
        return const SizedBox();
      }).toList(),
    );
  }

  void _seeChatWithUser(BuildContext context){

  }

  void _seeUser(BuildContext context){

  }

  void _resetSearch(BuildContext context) {
    BlocProvider.of<SearchBloc>(context).resetSearch();
  }

  void _handleSearch(String text, BuildContext context) {
    BlocProvider.of<SearchBloc>(context).searchFor(isSelected[0], text);
  }

  Widget _printSearchBar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.all(15),
      child: TextField(
        decoration: const InputDecoration(hintText: AppStrings.searchForSomeone),
        onSubmitted: (value) => _handleSearch(value, context),
      ),
    );
  }
}
