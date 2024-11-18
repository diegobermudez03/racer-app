import 'dart:convert';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class MapRepo{
   Future<Tuple2<String?, String?>> searchRoute(double lat1, double lon1, double lat2, double lon2);
   Future<Tuple2<String?, void>> saveRoute(
    double initialLat,
    double initialLon,
    DateTime initialDate,
    DateTime endingDate,
    double endingLat,
    double endingLon,
    Uint8List initialPic,
    Uint8List endingPic,
    double avgSpeed,
    double totalDistance,
    double calories,
    int seconds,
    List<double> distances
   );

}


class MapRepoImpl implements MapRepo{
  final routesUrl = 'https://maps.googleapis.com/maps/api/directions/json';
  final String apiKey;

  MapRepoImpl(this.apiKey);

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
  Future<Tuple2<String?, void>> saveRoute(
    double initialLat, double initialLon, DateTime initialDate, 
    DateTime endingDate, double endingLat, double endingLon, 
    Uint8List initialPic, Uint8List endingPic,
    double avgSpeed, double totalDistance, 
    double calories, int seconds, List<double> distances) 
  {
    throw UnimplementedError();
  }
  
}