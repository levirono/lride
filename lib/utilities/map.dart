import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';

class MapView extends StatefulWidget {
  final LatLng initialPosition;

  const MapView({super.key, required this.initialPosition});

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
    final ValueNotifier<double> _zoomNotifier = ValueNotifier(13.0);

  late MapController _mapController;
  late LatLng _currentPosition;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _currentPosition = widget.initialPosition;
    _getCurrentLocation();
    _mapController.mapEventStream.listen(_onMapEvent); 
  }
  void _onMapEvent(MapEvent mapEvent) {
    if (mapEvent is MapEventMove) {
      _zoomNotifier.value = _mapController.camera.zoom;
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
      _mapController.move(_currentPosition, _mapController.camera.zoom);
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _currentPosition,
            initialZoom: 13.0,
            onMapEvent: _onMapEvent,
          ),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/genixl/clvl3kmme011v01o0gh95hmt4/tiles/256/{z}/{x}/{y}@2x?access_token=${dotenv.env['MAPBOX_ACCESS_TOKEN']}',
          additionalOptions: {
            'accessToken': dotenv.env['MAPBOX_ACCESS_TOKEN']!,
            'id': 'mapbox.mapbox-streets-v8',
          },
        ),
      ],
    );
  }
}
