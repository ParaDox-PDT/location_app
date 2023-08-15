import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/ui/location/location_screen.dart';
import 'package:provider/provider.dart';

import '../providers/tab_box_provider.dart';
import 'map/map_screen.dart';

class TabBoxScreen extends StatefulWidget {
  const TabBoxScreen({super.key});

  @override
  State<TabBoxScreen> createState() => _TabBoxScreenState();
}

class _TabBoxScreenState extends State<TabBoxScreen> {
  List<Widget> screens = [];

  @override
  void initState() {
    screens.add(MapScreen());
    screens.add(LocationScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: context.watch<TabBoxProvider>().activeIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          context.read<TabBoxProvider>().changeIndex(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_pin), label: "User Addresses"),
        ],
      ),
    );
  }
}