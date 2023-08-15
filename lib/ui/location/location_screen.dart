import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../data/models/user_address.dart';
import '../../providers/address_call_provider.dart';
import '../../providers/location_provider.dart';
import '../../providers/tab_box_provider.dart';
import '../../providers/user_locations_provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    List<UserAddress> userAddresses =
        Provider.of<UserLocationsProvider>(context).addresses;
    return Scaffold(
      appBar: AppBar(title: const Text("User Locations Screen")),
      body: ListView(
        children: [
          if (userAddresses.isEmpty) const Text("EMPTY!!!"),
          ...List.generate(userAddresses.length, (index) {
            UserAddress userAddress = userAddresses[index];
            return ListTile(
              onTap: () {
                context.read<TabBoxProvider>().changeIndex(0);
                context.read<AddressCallProvider>().getAddressByLatLong(
                    latLng: LatLng(userAddress.lat, userAddress.long));

                context
                    .read<LocationProvider>()
                    .updateLatLong(LatLng(userAddress.lat, userAddress.long));
              },
              title: Text(userAddress.address),
              subtitle:
                  Text("Lat: ${userAddress.lat} and Longt:${userAddress.long}"),
            );
          })
        ],
      ),
    );
  }
}
