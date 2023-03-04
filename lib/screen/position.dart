import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyPosition extends StatefulWidget {
  const MyPosition({super.key});

  @override
  State<MyPosition> createState() => _MyPositionState();
}

class _MyPositionState extends State<MyPosition> {
  final Geolocator geolocator = Geolocator();

  late double latitude = 0;
  late double longitude = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Position"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$latitude"),
          Text("$longitude"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          latitude = position.latitude;
          longitude = position.longitude;
          setState(() {});
        },
        child: const Icon(
          Icons.location_on,
        ),
      ),
    );
  }
}
