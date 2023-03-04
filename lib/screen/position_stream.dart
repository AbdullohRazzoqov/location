import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class StreamPosition extends StatefulWidget {
  const StreamPosition({super.key});

  @override
  State<StreamPosition> createState() => _StreamPositionState();
}

class _StreamPositionState extends State<StreamPosition> {
  void getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print(position.latitude);
      print(position.longitude);
    } catch (e) {
      print(e);
    }
  }

  late StreamSubscription<Position> positionStream;
  late double latitude = 0.0;
  late double longitude = 0.0;

  void getPositionStream() {
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        
      });
      latitude = position.latitude;
      longitude = position.longitude;
      print(position.latitude);
      print(position.longitude);
    });
  }

  void stopListening() {
    if (positionStream != null) {
      positionStream.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    getPositionStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [Text('$latitude'), Text("$longitude")],
        ),
      ),
      appBar: AppBar(
        title: const Text("Position Stream"),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(onPressed: () {
            Stream<Position> getPositionStream({
              LocationSettings? locationSettings,
            }) =>
                GeolocatorPlatform.instance.getPositionStream(
                  locationSettings: locationSettings,
                );
            print(getPositionStream());
            getLocation();
          }),
          FloatingActionButton(
            onPressed: () {
              getPositionStream();
            },
            child: Text("Steam"),
          )
        ],
      ),
    );
  }
}
