import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/ui/location/location_screen.dart';

import 'package:flutter_defualt_project/ui/map/map_screen.dart';
import 'package:flutter_defualt_project/ui/splash/splash_screen.dart';
import 'package:flutter_defualt_project/ui/tab_box.dart';


class RouteNames {
  static const String homeScreen = "/homeScreen";
  static const String splashScreen = "/";
  static const String mapScreen = "/mapScreen";
  static const String tabBox = "/tabBox";
  static const String locationScreen = "/locationScreen";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RouteNames.tabBox:
        return MaterialPageRoute(
          builder: (context) => const TabBoxScreen(),
        );
      case RouteNames.locationScreen:
        return MaterialPageRoute(
          builder: (context) => const LocationScreen(),
        );
      case RouteNames.mapScreen:
        return MaterialPageRoute(
          builder: (context) =>  const MapScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route not found!"),
            ),
          ),
        );
    }
  }
}