import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:racer_app/entities/event_entity.dart';
import 'package:racer_app/entities/user_entity.dart';

abstract class SearchState{}

class SearchInitialState implements SearchState{}

class SearchLoadingState implements SearchState{}

class SearchFailureState implements SearchState{
  final String message;
  SearchFailureState(this.message);
}

class SearchUsersSuccess implements SearchState{
  final List<Tuple2<UserEntity, String>> users;

  SearchUsersSuccess(this.users);
}

class SearchEventsSuccess implements SearchState{
  final List<Tuple2<EventEntity, String>> events;

  SearchEventsSuccess(this.events);
}