import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../ui/map/map_screen.dart';
import '../utils/utility_function.dart';

class LocationProvider with ChangeNotifier {
  LocationProvider() {
    _getLocation();
  }
  Set<Marker> markers = {};

  LatLng? latLong;
  LatLng? initialLatLong;


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


    try{
      locationData = await location.getLocation();
      initialLatLong=LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
      latLong = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );

      debugPrint("SUCCESS ERROR:${latLong!.longitude}");
      notifyListeners();
    }catch(er){
      debugPrint("LOCATION ERROR:$er");
    }

    location.enableBackgroundMode(enable: true);

    location.onLocationChanged.listen((LocationData newLocation)
    {
      LatLng latLng = LatLng(newLocation.latitude!, newLocation.longitude!);
      addNewMarker(latLng);
      debugPrint("LONGITUDE:${newLocation.longitude}");
    });
    notifyListeners();

  }

  updateLatLong(LatLng newLatLng) {
    latLong = newLatLng;
    notifyListeners();
  }

  addNewMarker(LatLng latLng) async {
    // Uint8List uint8list = await getBytesFromAsset("assets/images/google_pin.png", 50);
    markers.add(Marker(
        markerId: MarkerId(
          DateTime.now().toString(),
        ),
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,

        infoWindow: const InfoWindow(
            title: 'Toshkent', snippet: "Falonchi Ko'chasi 45-uy ")));
    notifyListeners();
  }


}