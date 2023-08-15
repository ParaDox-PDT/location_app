import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_defualt_project/ui/map/widgets/address_kind_selector.dart';
import 'package:flutter_defualt_project/ui/map/widgets/address_lang_selector.dart';
import 'package:flutter_defualt_project/ui/map/widgets/save_button.dart';
import 'package:flutter_defualt_project/ui/map/widgets/typeOfMap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../data/models/user_address.dart';
import '../../providers/address_call_provider.dart';
import '../../providers/location_provider.dart';
import '../../providers/user_locations_provider.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late CameraPosition initialCameraPosition;
  late CameraPosition currentCameraPosition;
  bool onCameraMoveStarted = false;

  Set<Marker> markers = {};

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    addNewMarker(locationProvider.latLong!);

    initialCameraPosition = CameraPosition(
      target: locationProvider.initialLatLong!,
      zoom: 13,
    );

    currentCameraPosition = CameraPosition(
      target: locationProvider.latLong!,
      zoom: 13,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(

            myLocationButtonEnabled: false,
            onLongPress: (latLng) {
              addNewMarker(latLng);
            },
            markers: markers,
            onCameraMove: (CameraPosition cameraPosition) {
              currentCameraPosition = cameraPosition;
            },
            onCameraIdle: () {
              debugPrint(
                  "CURRENT CAMERA POSITION: ${currentCameraPosition.target.latitude}");

              context
                  .read<AddressCallProvider>()
                  .getAddressByLatLong(latLng: currentCameraPosition.target);

              setState(() {
                onCameraMoveStarted = false;
              });

              debugPrint("MOVE FINISHED");
            },
            liteModeEnabled: false,
            myLocationEnabled: true,
            padding: const EdgeInsets.all(16),
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            mapType: context.watch<AddressCallProvider>().mapType,
            onCameraMoveStarted: () {
              setState(() {
                onCameraMoveStarted = true;
              });
              debugPrint("MOVE STARTED");
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: initialCameraPosition,
          ),
          Align(
            child: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: onCameraMoveStarted ? 50 : 32,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 150),
              child: Container(
                color: Colors.black38,
                child: Text(
                  context.watch<AddressCallProvider>().scrolledAddressText,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            top: 20,
            right: 0,
            child: KindOfAddress(),
          ),
          const Positioned(
            top: 60,
            right: 0,
            child: LanguageOfAddress(),
          ),
          const Positioned(
            top: 100,
            right: 0,
            child: TypeOfMap(),
          ),
          Positioned(
            bottom: 20,
            right: MediaQuery.of(context).size.width/2-30,
            child: Visibility(
              visible: context.watch<AddressCallProvider>().canSaveAddress(),
              child: SaveButton(onTap: () {
                AddressCallProvider adp =
                    Provider.of<AddressCallProvider>(context, listen: false);
                context.read<UserLocationsProvider>().insertUserAddress(
                      UserAddress(
                        lat: currentCameraPosition.target.latitude,
                        long: currentCameraPosition.target.longitude,
                        address: adp.scrolledAddressText,
                        created: DateTime.now().toString(),
                      ),
                    );
              }),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _followMe(cameraPosition: initialCameraPosition);
        },
        child: const Icon(Icons.gps_fixed),
      ),
    );
  }

  Future<void> _followMe({required CameraPosition cameraPosition}) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  addNewMarker(LatLng latLng) async {
    // Uint8List uint8list = await getBytesFromAsset("assets/courier.png", 150);
    markers.add(Marker(
        markerId: MarkerId(
          DateTime.now().toString(),
        ),
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
        //BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
            title: "Samarqand", snippet: "Falonchi Ko'chasi 45-uy ")));
    setState(() {});
  }
}
