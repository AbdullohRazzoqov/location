import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Geolocator geolocator = Geolocator();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  late double latitude = 0;
  late double longitude = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("$latitude"), Text("$longitude")],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Future<Position> abs = _determinePosition();
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);

          setState(() {
            const LocationSettings locationSettings = LocationSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 100,
            );
            StreamSubscription<Position> positionStream =
                Geolocator.getPositionStream(locationSettings: locationSettings)
                    .listen((Position? position) {
              print(position == null
                  ? 'Unknown'
                  : '${position.latitude.toString()}, ${position.longitude.toString()}');
                  if (position != null) {
              latitude = position.latitude;
              longitude = position.longitude;
            }
            });
            
          });
          print(abs);
        },
        child: const Icon(Icons.location_on),
      ),
    );
  }
}
