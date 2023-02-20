import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';

void main() => runApp(DeviceInfoApp());

class DeviceInfoApp extends StatefulWidget {
  @override
  _DeviceInfoAppState createState() => _DeviceInfoAppState();
}

class _DeviceInfoAppState extends State<DeviceInfoApp> {
  AndroidDeviceInfo? _androidDeviceInfo;

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    setState(() {
      _androidDeviceInfo = androidInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device Info App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Device Info'),
        ),
        body: Center(
          child: _androidDeviceInfo != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Manufacturer: ${_androidDeviceInfo!.manufacturer}'),
                    Text('Model: ${_androidDeviceInfo!.model}'),
                    Text('SDK Version: ${_androidDeviceInfo!.version.sdkInt}'),
                    Text('Version Code: ${_androidDeviceInfo!.version.codename}'),
                  ],
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}