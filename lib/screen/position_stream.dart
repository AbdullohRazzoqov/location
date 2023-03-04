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
  
  void getPositionStream() {
    positionStream = Geolocator.getPositionStream().listen((Position position) {
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
  Widget build(BuildContext context) {
    return Scaffold(
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
