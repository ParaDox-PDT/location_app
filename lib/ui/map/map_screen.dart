import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.latLong});

  final LatLng latLong;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late CameraPosition initialCameraPosition;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    initialCameraPosition = CameraPosition(target: widget.latLong, zoom: 15);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (controller) {
              _controller.complete(controller);
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.location_on,
              color: Colors.red,
              size: 30,
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.my_location_outlined),
      ),
    );
  }
}
