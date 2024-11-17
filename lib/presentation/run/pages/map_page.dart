import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:location/location.dart';
import 'package:racer_app/core/app_strings.dart';

class MapPage extends StatefulWidget {

  final String googleAPiKey;

  MapPage({
    super.key,
    required this.googleAPiKey
  });
  
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  final searchController = TextEditingController();
  Location _location = Location();
  LatLng _currentUserLocation = LatLng(37.7749, -122.4194);
  final Set<Marker> _markers = {};
  Marker? destination;


  Future<void> _getUserLocation() async {
    final userLocation = await _location.getLocation();
    setState(() {
      _currentUserLocation = LatLng(userLocation.latitude!, userLocation.longitude!);
    });
    _mapController.animateCamera(
      CameraUpdate.newLatLng(_currentUserLocation),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.run)),
      body: Column(
        children: [
          GooglePlacesAutoCompleteTextFormField(
            textEditingController: searchController,
            googleAPIKey: widget.googleAPiKey,
            countries: ['col'],
            isLatLngRequired: true,
            getPlaceDetailWithLatLng: (prediction){
              _selectDestintation(LatLng(double.parse(prediction.lat!), double.parse(prediction.lng!)));
            },
            itmClick: (prediction) {
              searchController.text = prediction.description ?? '';
              searchController.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description?.length ?? 0));
            }
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
                _getUserLocation();
              },
              initialCameraPosition: CameraPosition(
                target: _currentUserLocation,
                zoom: 14,
              ),
              myLocationEnabled: true,
              markers: _markers,
              onLongPress: (loc)=>_selectDestintation(loc),
            ),
          ),
          ElevatedButton(
            onPressed: destination != null ? _startRunning : null, 
            child: Text(AppStrings.start),
          ),
        ],
      ),
    );
  }

  void _startRunning(){

  }

  void _selectDestintation(LatLng position){
    if(destination == null){
      destination = Marker(
        markerId: MarkerId('1'), 
        position: position
      );
    }else{
      destination = Marker(
        markerId: destination!.markerId,
        position: position
      );
    }
    _mapController.animateCamera(CameraUpdate.newLatLng(_currentUserLocation),);
  }



  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return polyline;
  }

  
}

