import 'package:dartz/dartz.dart';

class EventEntity{
  final String id;
  final String name;
  final DateTime eventDate;
  final List<Tuple2<String, String>> suscribers;  //id, userName

  EventEntity(this.id, this.name, this.eventDate, this.suscribers);
}