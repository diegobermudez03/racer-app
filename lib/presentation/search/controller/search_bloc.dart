import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/entities/event_entity.dart';
import 'package:racer_app/entities/user_entity.dart';
import 'package:racer_app/presentation/search/controller/search_states.dart';
import 'package:racer_app/repository/general_repo.dart';

class SearchBloc extends Cubit<SearchState>{

  final GeneralRepo repo;

  SearchBloc(this.repo):super(SearchInitialState());


  void resetSearch() async{

  }

  void searchFor(bool users, String text)async{
    await Future.delayed(Duration.zero);
    emit(SearchLoadingState());

    final Tuple2<String?,List<Tuple2<dynamic, String>>?> response = users ? await repo.searchUsers(text) : await repo.searchUsers(text);

    if(response.value1 != null){
      emit(SearchFailureState(response.value1!));
    }else{
      emit( users ? 
        SearchUsersSuccess(response.value2! as List<Tuple2<UserEntity, String>> ):  
        SearchEventsSuccess(response.value2! as List<Tuple2<EventEntity, String>>) 
      );
    }
  }
}