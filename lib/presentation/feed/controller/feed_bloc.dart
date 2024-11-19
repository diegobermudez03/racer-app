import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/presentation/feed/controller/feed_states.dart';
import 'package:racer_app/repository/map_repo.dart';

class FeedBloc extends Cubit<FeedState>{

  final MapRepo repo;

  FeedBloc(this.repo):super(FeedInitialState());


  void gerRoutes(String? userId) async{
    await Future.delayed(Duration.zero);
  }
}