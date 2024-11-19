import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoutePost extends StatelessWidget{

  final String userName;
  final String initialPicUrl;
  final String finalPicUrl;
  final DateTime endingDate;
  final double avgSpeed;
  final double distance;
  final int seconds;
  final double calories;


  RoutePost({
    super.key,
    required this.userName,
    required this.initialPicUrl,
    required this.finalPicUrl,
    required this.endingDate,
    required this.avgSpeed,
    required this.distance,
    required this.seconds,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(userName),
              Text(endingDate.toString())
            ],
          ),
          Row(
            children: [
              CachedNetworkImage(imageUrl: initialPicUrl),
              CachedNetworkImage(imageUrl: finalPicUrl),
            ],
          ),
        ],
      ),
    );
  }
}