import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:location/location.dart';
import 'package:racer_app/core/app_strings.dart';
import 'package:racer_app/presentation/run/controller/map_bloc.dart';
import 'package:racer_app/presentation/run/controller/map_states.dart';
import 'package:racer_app/shared/camera_handler.dart';
import 'package:racer_app/utilities/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  final String googleAPiKey;

  const MapPage({super.key, required this.googleAPiKey});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  final searchController = TextEditingController();
  final _location = Location();
  final Set<Marker> _markers = {};
  var _currentUserLocation = const LatLng(4.67952, -74.0874);
  Polyline? route;
  Marker? destination;
  bool _routeInProgress = false;

  Future<void> _getUserLocation(MapBloc provider) async {
    final userLocation = await _location.getLocation();
    _location.onLocationChanged.listen((newLoc) {
      _currentUserLocation = LatLng(newLoc.latitude!, newLoc.longitude!);
      _mapController.animateCamera(
        CameraUpdate.newLatLng(_currentUserLocation),
      );
      if (_routeInProgress) {
        provider.updateToProgress(newLoc.latitude!, newLoc.longitude!);
      }
    });
    setState(() {
      _currentUserLocation = LatLng(userLocation.latitude!, userLocation.longitude!);
    });
    _mapController.animateCamera(
      CameraUpdate.newLatLng(_currentUserLocation),
    );
  }

  @override
  Widget build(BuildContext context) {
  final provider = BlocProvider.of<MapBloc>(context);
  final colorScheme = Theme.of(context).colorScheme;

  return Scaffold(
    appBar: AppBar(
      title: const Text(AppStrings.run),
      backgroundColor: colorScheme.primaryContainer,
      foregroundColor: colorScheme.onPrimaryContainer,
    ),
    body: BlocListener<MapBloc, MapState>(
      listener: (context, state) {
        if (state is MapRouteEnded) {
          CustomDialogs.showSuccessDialog(context, AppStrings.routeSavedAndPublished);
        }
        if (state is MapRouteFailure) {
          CustomDialogs.showFailureDialog(context, state.message);
        }
      },
      child: Stack(
        children: [
          // Map Display
          BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              final Set<Polyline> routes = {};
              if (state is MapRouteRetrieved) {
                route = Polyline(
                    polylineId: const PolylineId('1'),
                    color: Colors.red,
                    width: 5,
                    points: _decodePolyline(state.route));
                routes.add(route!);
              } else if (route != null) {
                routes.add(route!);
              }
              if (state is MapRouteFailure || state is MapRouteEnded) {
                routes.clear();
                _markers.clear();
                destination = null;
                _routeInProgress = false;
              }
              return GoogleMap(
                onMapCreated: (controller) {
                  _mapController = controller;
                  _getUserLocation(provider);
                },
                initialCameraPosition: CameraPosition(
                  target: _currentUserLocation,
                  zoom: 14,
                ),
                myLocationEnabled: true,
                markers: _markers,
                polylines: routes,
                onLongPress: !_routeInProgress ? (loc) => _selectDestintation(loc, context) : null,
              );
            },
          ),
          // Button Positioned on Top of the Map
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _routeInProgress
                  ? (() => _endRoute(context))
                  : (destination != null ? () => _startRunning(context) : null),
              style: ElevatedButton.styleFrom(
                backgroundColor: _routeInProgress ? colorScheme.errorContainer : colorScheme.primary,
                foregroundColor: _routeInProgress ? colorScheme.onErrorContainer : colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                !_routeInProgress ? AppStrings.start : AppStrings.endRoute,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          // Search Input or In-Progress Status (can also be placed on top)
          if (!_routeInProgress)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GooglePlacesAutoCompleteTextFormField(
                    textEditingController: searchController,
                    googleAPIKey: widget.googleAPiKey,
                    countries: const ['col'],
                    isLatLngRequired: true,
                    getPlaceDetailWithLatLng: (prediction) {
                      _selectDestintation(
                          LatLng(double.parse(prediction.lat!), double.parse(prediction.lng!)), context);
                    },
                    itmClick: (prediction) {
                      searchController.text = prediction.description ?? '';
                      searchController.selection =
                          TextSelection.fromPosition(TextPosition(offset: prediction.description?.length ?? 0));
                    },
                  ),
                ),
              ),
            ),
          if (_routeInProgress)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppStrings.inProgress,
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

  void _endRoute(BuildContext context) async {
    final distance = Geolocator.distanceBetween(_currentUserLocation.latitude, _currentUserLocation.longitude,
        destination!.position.latitude, destination!.position.longitude);
    //if its more than 100 meters, like the diameter, then its not able to end
    if (distance > 100) {
      CustomDialogs.showFailureDialog(context, AppStrings.haventReachedDestiny);
      return;
    }
    final endigTime = DateTime.now();
    final endingPicture = await CameraHandler.takePicture(context);
    if (endingPicture == null) {
      CustomDialogs.showFailureDialog(context, AppStrings.unableToTakePictureCantEndRoute);
      return;
    }
    BlocProvider.of<MapBloc>(context)
        .endRoute(endingPicture, _currentUserLocation.latitude, _currentUserLocation.longitude, endigTime);
  }

  void _startRunning(BuildContext context) async {
    final initialPicture = await CameraHandler.takePicture(context);
    if (initialPicture == null) {
      CustomDialogs.showFailureDialog(context, AppStrings.unableToTakePictureCantStartRoute);
      return;
    }
    setState(() {
      _routeInProgress = true;
    });
    BlocProvider.of<MapBloc>(context)
        .startRoute(initialPicture, _currentUserLocation.latitude, _currentUserLocation.longitude);
  }

  void _selectDestintation(LatLng position, BuildContext context) {
    BlocProvider.of<MapBloc>(context).getRoute(_currentUserLocation, position);
    if (destination == null) {
      destination = Marker(markerId: const MarkerId('1'), position: position, icon: BitmapDescriptor.defaultMarker);
    } else {
      destination = Marker(markerId: destination!.markerId, position: position, icon: BitmapDescriptor.defaultMarker);
    }
    setState(() {});
    _markers.add(destination!);
    _mapController.animateCamera(
      CameraUpdate.newLatLng(position),
    );
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
