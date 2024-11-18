import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
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

  void endRoute(File endingPicture, double endingLat, double endingLon, DateTime endingTime)async{
    final auxState = state as MapRouteInProgress;
    final result = _calculatePoints(endingTime);
    final startPicture = await (state as MapRouteInProgress).initialPic.readAsBytes();
    final endPicture = await endingPicture.readAsBytes();
    final totalSec = endingTime.difference((state as MapRouteInProgress).startingDate).inSeconds;
    final response = await repo.saveRoute(
      (state as MapRouteInProgress).initialLat, 
      (state as MapRouteInProgress).initiaLon,
      (state as MapRouteInProgress).startingDate, 
      endingTime, 
      endingLat, 
      endingLon, 
      startPicture, 
      endPicture,
      result.value2/totalSec, 
      result.value2, 
      (result.value2/totalSec)*(totalSec/60), 
      totalSec,
      result.value1
    );
    if(response.value1 != null){
      emit(MapRouteFailure(response.value1!));
    }else{
      emit(MapRouteEnded());
    }
  }

  void updateToProgress(double lat, double lon){
    (state as MapRouteInProgress).points.add(Tuple2(DateTime.now(), Tuple2(lat, lon)));
  }


  Tuple2<List<double>, double> _calculatePoints(DateTime endingTime){
    final startingTime = (state as MapRouteInProgress).startingDate;
    final lapse = endingTime.difference(startingTime);
    final int seconds = (lapse.inSeconds)~/10;
    final points = (state as MapRouteInProgress).points;
    final List<double> result = [];

    double distance = 0;
    double totalDistance = 0;
    int index = 0;
    
    double prevLat = (state as MapRouteInProgress).initialLat;
    double prevLon = (state as MapRouteInProgress).initiaLon;
    for(int i = 1; i <= 10; i++){
      distance = 0;
      for(int j = index; index < points.length; index++){
        distance += Geolocator.distanceBetween(prevLon, prevLat, points[j].value2.value1, points[j].value2.value1);
        totalDistance += distance;
        if(points[j].value1.isAfter(startingTime.add(Duration(seconds: seconds*i)))){
          index = j+1;
          break;
        }
        prevLat = points[j].value2.value1;
        prevLon =  points[j].value2.value2;
      }
      result.add(distance/seconds);
    }

    return Tuple2(result, totalDistance);
  }


}