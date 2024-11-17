import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/core/app_strings.dart';
import 'package:racer_app/presentation/search/controller/search_bloc.dart';
import 'package:racer_app/presentation/search/controller/search_states.dart';

class SearchPage extends StatefulWidget{

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _printSearchBar(context),
        ToggleButtons(
          children: [
            Padding( 
              padding: EdgeInsets.all(8),
              child: Text(AppStrings.users),
            ),
            Padding( 
              padding: EdgeInsets.all(8),
              child: Text(AppStrings.events),
            ),
          ], 
          isSelected: isSelected,
          onPressed: (index){
            setState(() {
              isSelected[index] = true;
              int other = index == 0? 1:0;
              isSelected[other] = false;
              _resetSearch(context);
            });
          },
        ),

        BlocBuilder<SearchBloc, SearchState>(builder: (context, state){
          return SizedBox();
        })
      ],
    );
  }

  void _resetSearch(BuildContext context){
    
  }

  void _handleSearch(String text, BuildContext context){

  }


  Widget _printSearchBar(BuildContext context){
    return Container(
      width: double.infinity,
      height: 50,
      padding: EdgeInsets.all(15),
      child: TextField( 
        decoration: InputDecoration(hintText: AppStrings.searchForSomeone),
        onSubmitted: (value) => _handleSearch(value, context),
      ),
    );
  }
}