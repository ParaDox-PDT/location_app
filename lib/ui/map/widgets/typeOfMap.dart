import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/providers/address_call_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../../utils/images.dart';

class TypeOfMap extends StatelessWidget {
  const TypeOfMap({super.key});



  @override
  Widget build(BuildContext context) {
    final provider= Provider.of<AddressCallProvider>(context);
    return PopupMenuButton<MapType>(
      color: Colors.black.withOpacity(0.8),
      icon: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.black.withOpacity(0.8)),
        child: Icon(
          Icons.map_rounded,
          color: provider.mapType == MapType.satellite
              ? const Color(0xFF00ACC1)
              : provider.mapType == MapType.hybrid
              ? const Color(0xFF00ACC1)
              : Colors.white,
        ),
      ),
      onSelected: (MapType result) {
        provider.mapType=result;
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MapType>>[
        _buildMapTypeMenuItem(
          provider: provider,
          text: 'Normal',
          mapType: MapType.normal,
          iconPath: AppImages.normal,
        ),
        _buildMapTypeMenuItem(
          provider: provider,
          text: 'Satellite',
          mapType: MapType.satellite,
          iconPath: AppImages.satellite,
        ),
        _buildMapTypeMenuItem(
          provider: provider,
          text: 'Hybrid',
          mapType: MapType.hybrid,
          iconPath: AppImages.hybrid,
        ),
        _buildMapTypeMenuItem(
          provider: provider,
          text: 'Terrain',
          mapType: MapType.terrain,
          iconPath: AppImages.terrain,
        ),
      ],
    );
  }

  PopupMenuItem<MapType> _buildMapTypeMenuItem({
    required AddressCallProvider provider,
    required String text,
    required MapType mapType,
    required String iconPath,
  }) {
    return PopupMenuItem<MapType>(
      onTap: () {

      },
      value: mapType,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style:  TextStyle( color:provider.mapType==mapType?Colors.blue: Colors.white),
          ),
          Image.asset(iconPath, height: 30, width: 30),
        ],
      ),
    );
  }
}

