import 'dart:convert';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:racer_app/entities/route_entity.dart';
import 'package:racer_app/repository/auth_repo.dart';

abstract class MapRepo{
   Future<Tuple2<String?, String?>> searchRoute(double lat1, double lon1, double lat2, double lon2);
   Future<Tuple2<String?, void>> saveRoute(RouteEntity route);

}


class MapRepoImpl implements MapRepo{
  final routesUrl = 'https://maps.googleapis.com/maps/api/directions/json';
  final String apiKey;
  final DatabaseReference database;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  MapRepoImpl(
    this.database,
    this.auth,
    this.storage,
    this.apiKey
  );

  @override
  Future<Tuple2<String?, String?>> searchRoute(double lat1, double lon1, double lat2, double lon2) async{
    final String url = '$routesUrl?origin=$lat1,$lon1&destination=$lat2,$lon2&mode=walking&key=$apiKey';
    try{
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final route = data['routes'][0];
          final polylinePoints = route['overview_polyline']['points'];
          return Tuple2(null, polylinePoints);
        } else {
          return const Tuple2('error', null);
        }
      } else {
       return const Tuple2('error', null);
      }
    }catch(e){
      return Tuple2(e.toString(), null);
    }
  }
  
  @override
  Future<Tuple2<String?, void>> saveRoute(RouteEntity route) async
  {
    try{
      final userId = auth.currentUser!.uid;
      DatabaseReference newRouteRef = database.child('routes').push();
      final String routeId = newRouteRef.key!;

      final String initialDateString = route.initialDate.toIso8601String();
      final String endingDateString = route.endingDate.toIso8601String();

      final String initialPicPath = 'routes/$routeId/initialpic';
      final String endingPicPath = 'routes/$routeId/endingpic';

      await storage.ref(initialPicPath).putData(route.initialPic);

      await storage.ref(endingPicPath).putData(route.endingPic);

      final Map<String, dynamic> routeData = {
        'username': AuthRepoFirebase.currentUser?.userName,
        'initialLat': route.initialLat,
        'initialLon': route.initialLon,
        'initialDate': initialDateString,
        'endingDate': endingDateString,
        'endingLat': route.endingLat,
        'endingLon': route.endingLon,
        'avgSpeed': route.avgSpeed,
        'totalDistance': route.totalDistance,
        'calories': route.calories,
        'seconds': route.seconds,
        'distances': route.distances,
        'publisher': userId,
      };
      await newRouteRef.set(routeData);
      
      return Tuple2(null, null);
    }catch(e){
      return Tuple2(e.toString(), null);
    }
  }
  
}