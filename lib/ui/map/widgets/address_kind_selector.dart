import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/providers/address_call_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';


class KindOfAddress extends StatefulWidget {
  const KindOfAddress({Key? key}) : super(key: key);

  @override
  State<KindOfAddress> createState() => _KindOfAddressState();
}

class _KindOfAddressState extends State<KindOfAddress> {
  @override
  Widget build(BuildContext context) {
    final addressCallProvider = Provider.of<AddressCallProvider>(context);
    int selectedIndex = addressCallProvider.kindIndex;

    return PopupMenuButton<int>(
      color: Colors.black.withOpacity(0.8),
      icon: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.black.withOpacity(0.8),
        ),
        child: selectedIndex == 0
            ? const Icon(CupertinoIcons.home, color: Colors.white, size: 18)
            : selectedIndex == 1
            ? const Icon(Icons.directions_subway_outlined,
            color: Colors.blueAccent, size: 20)
            : selectedIndex == 2
            ? const Icon(CupertinoIcons.location_fill,
            color: Colors.amber, size: 20)
            : const Icon(Icons.line_axis,
            color: Colors.green, size: 20),
      ),
      initialValue: selectedIndex,
      onSelected: (int index) {
        addressCallProvider.kindIndex = index;
        String selectedValue = kindList[index];
        context.read<AddressCallProvider>().updateKind(selectedValue);
        setState(() {

        });
      },
      itemBuilder: (BuildContext context) {
        return kindList.asMap().entries.map((MapEntry<int, String> entry) {
          int index = entry.key;
          IconData iconData;
          switch (index) {
            case 1:
              iconData = Icons.directions_subway_outlined;
              break;
            case 2:
              iconData = CupertinoIcons.location;
              break;
            case 3:
              iconData = Icons.line_axis;
              break;
            default:
              iconData = CupertinoIcons.home;
          }

          String text;
          switch (index) {
            case 1:
              text = 'Subway';
              break;
            case 2:
              text = 'District';
              break;
            case 3:
              text = 'Street';
              break;
            default:
              text = 'Home';
          }

          return PopupMenuItem<int>(
            value: index,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(iconData, color: Colors.white),
                const SizedBox(width: 10),
                Text(text, style: const TextStyle(color: Colors.white)),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}