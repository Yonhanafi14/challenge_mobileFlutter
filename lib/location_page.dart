import 'package:flutter/material.dart';
import 'package:location/location.dart';

void main() => runApp(GPSCoordinate());

class GPSCoordinate extends StatefulWidget {
  @override
  _GPSCoordinateState createState() => _GPSCoordinateState();
}

class _GPSCoordinateState extends State<GPSCoordinate> {
  Location location = Location();
  LocationData? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    try {
      var locationData = await location.getLocation();
      setState(() {
        _currentLocation = locationData;
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPS Coordinate App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('GPS Coordinate'),
        ),
        body: Center(
          child: _currentLocation != null
              ? Text(
                  'Latitude: ${_currentLocation!.latitude}, Longitude: ${_currentLocation!.longitude}')
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}