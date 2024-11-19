import 'dart:typed_data';

class RouteEntity{
  final String? userName;
  final double initialLat;
  final double initialLon;
  final DateTime initialDate;
  final DateTime endingDate;
  final double endingLat;
  final double endingLon;
  final Uint8List? initialPic;
  final Uint8List? endingPic;
  final String? initialPicUrl;
  final String? endingPicUrl;
  final double avgSpeed;
  final double totalDistance;
  final double calories;
  final int seconds;
  final List<double> distances;

  RouteEntity(
    this.initialLat, 
    this.initialLon, 
    this.initialDate, 
    this.endingDate, 
    this.endingLat, 
    this.endingLon,
    this.initialPic, 
    this.endingPic, 
    this.avgSpeed, 
    this.totalDistance, 
    this.calories, 
    this.seconds, 
    this.distances,
    [this.userName, this.initialPicUrl, this.endingPicUrl]
  );
}