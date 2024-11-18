import 'dart:io';

import 'package:dartz/dartz.dart';

abstract class MapState{}

class MapInitialState implements MapState{}

class MapRouteRetrieved implements MapState{
  final String route;

  MapRouteRetrieved(this.route);
}

class MapRouteInProgress implements MapState{
  final DateTime startingDate;
  final double initialLat;
  final double initiaLon;
  final File initialPic;
  List<Tuple2<DateTime, Tuple2<double, double>>> points = [];

  MapRouteInProgress(this.startingDate, this.initialLat, this.initiaLon, this.initialPic);
}