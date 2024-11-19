import 'package:racer_app/entities/route_entity.dart';

abstract class FeedState{}

class FeedInitialState implements FeedState{}

class FeedLoadingState implements FeedState{}


class FeedFailureState implements FeedState{
  final String message;
  FeedFailureState(this.message);
}


class FeedRetrievedState implements FeedState{
  final List<RouteEntity> routes;

  FeedRetrievedState(this.routes);
}