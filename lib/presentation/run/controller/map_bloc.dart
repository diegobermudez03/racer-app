import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:racer_app/presentation/run/controller/map_states.dart';

class MapBloc extends Cubit<MapState>{

  MapBloc():super(MapInitialState());


  void getRoute(LatLng initialPos, LatLng endingPos) async{
    
  }
}