import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/core/app_strings.dart';
import 'package:racer_app/core/custom_navigator.dart';
import 'package:racer_app/entities/user_entity.dart';
import 'package:racer_app/presentation/search/controller/search_bloc.dart';
import 'package:racer_app/presentation/search/controller/search_states.dart';
import 'package:racer_app/presentation/search/widgets/user_tile.dart';
import 'package:racer_app/utilities/custom_dialogs.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _printSearchBar(context),
         _buildToggleButtons(
            context,
            isSelected,
            (index) {
              setState(() {
                isSelected[index] = true;
                int other = index == 0 ? 1 : 0;
                isSelected[other] = false;
                _resetSearch(context);
              });
            },
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
    return SingleChildScrollView(
      child: Column(
        children: results.map((tple){
          if(tple.value1 is UserEntity){
            final us = tple.value1 as UserEntity;
            return UserTile(
              user: us, 
              profilePictureUrl: tple.value2, 
              onSeeUserPressed: ()=>_seeUser(context), 
              onChatPressed: ()=>_seeChatWithUser(context, us.id, tple.value2)
            );
          }
          return const SizedBox();
        }).toList(),
      ),
    );
  }

  void _seeChatWithUser(BuildContext context, String userId, String profileUrl){
    CustomNavigator.goToChatWithUser(context, null, userId, profileUrl);
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
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        onSubmitted: (value) => _handleSearch(value, context),
        decoration: InputDecoration(
          hintText: AppStrings.searchForSomeone,
          hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
          prefixIcon: Icon(
            Icons.search,
            color: colorScheme.primary,
          ),
          filled: true,
          fillColor: colorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.primary,
              width: 1.5,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
        style: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 16,
        ),
      ),
    );
  }


  Widget _buildToggleButtons(BuildContext context, List<bool> isSelected, Function(int) onToggle) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ToggleButtons(
        borderRadius: BorderRadius.circular(12),
        borderColor: colorScheme.outline,
        selectedBorderColor: colorScheme.primary,
        fillColor: colorScheme.primary.withOpacity(0.15),
        selectedColor: colorScheme.primary,
        color: colorScheme.onSurface,
        isSelected: isSelected,
        onPressed: (index) {
          onToggle(index);
        },
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              AppStrings.users,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              AppStrings.events,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
