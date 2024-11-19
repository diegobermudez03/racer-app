import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/entities/route_entity.dart';
import 'package:racer_app/presentation/feed/controller/feed_bloc.dart';
import 'package:racer_app/presentation/feed/controller/feed_states.dart';
import 'package:racer_app/presentation/feed/widgets/route_post.dart';

class FeedPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<FeedBloc, FeedState>(builder: (context, state){
        if(state is FeedInitialState){
          BlocProvider.of<FeedBloc>(context).gerRoutes(null);
        }
        return switch(state){
          FeedFailureState(message: final msg) => Center(child: Text(msg),),
          FeedLoadingState()=> Center(child: CircularProgressIndicator(),),
          FeedRetrievedState(routes: final rts) => _printFeed(rts),
          FeedState() => SizedBox()
        };
      }),
    );
  }


  Widget _printFeed(List<RouteEntity> routes){
    return Column(
      children: routes.map((r)=>RoutePost(
        userName: r.userName!, 
        initialPicUrl: r.initialPicUrl!, 
        finalPicUrl: r.endingPicUrl!, 
        endingDate: r.endingDate, 
        avgSpeed: r.avgSpeed, 
        distance: r.totalDistance, 
        seconds: r.seconds, 
        calories: r.calories)
      ).toList(),
    );
  }
}