import 'package:flutter/material.dart';
import 'package:location/location.dart';

void main() => runApp(LocationApp());

class LocationApp extends StatefulWidget {
  @override
  _LocationAppState createState() => _LocationAppState();
}

class _LocationAppState extends State<LocationApp> {
  Location location = Location();
  LocationData? _locationData;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    try {
      var locationData = await location.getLocation();
      setState(() {
        _locationData = locationData;
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Location'),
        ),
        body: Center(
          child: _locationData != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Latitude: ${_locationData!.latitude}'),
                    Text('Longitude: ${_locationData!.longitude}'),
                  ],
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}