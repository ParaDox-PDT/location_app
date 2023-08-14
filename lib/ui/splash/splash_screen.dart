import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/ui/app_routes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LatLng? latLong;

  Future<void> _getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    setState(() {
      latLong = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
    });
  }

  _init() async {
    await _getLocation();

    await Future.delayed(const Duration(seconds: 1));

    if (context.mounted&&latLong!=null) {
      Navigator.pushReplacementNamed(context, RouteNames.mapScreen,arguments: latLong);
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Splash Screen:${latLong?.latitude}  and ${latLong?.longitude}  "),
      ),
    );
  }
}