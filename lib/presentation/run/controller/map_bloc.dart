import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:racer_app/presentation/run/controller/map_states.dart';
import 'package:racer_app/repository/map_repo.dart';

class MapBloc extends Cubit<MapState>{

  final MapRepo repo;

  MapBloc(this.repo):super(MapInitialState());


  void getRoute(LatLng initialPos, LatLng endingPos) async{
    final response = await repo.searchRoute(initialPos.latitude, initialPos.longitude, endingPos.latitude, endingPos.longitude);
    if(response.value2 != null){
      emit(MapRouteRetrieved(response.value2!));
    }
  }

  void startRoute(File initialPicture, double initialLat, double initialLon){
    emit(MapRouteInProgress(DateTime.now(), initialLat, initialLon, initialPicture));
  }

  void endRoute(File endingPicture, double endingLat, double endingLon, DateTime endingTime){
    final auxState = state as MapRouteInProgress;
  }

  void updateToProgress(double lat, double lon){
    (state as MapRouteInProgress).points.add(Tuple2(DateTime.now(), Tuple2(lat, lon)));
  }


}