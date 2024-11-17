import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/presentation/search/controller/search_states.dart';

class SearchBloc extends Cubit<SearchState>{

  SearchBloc():super(SearchInitialState());
}