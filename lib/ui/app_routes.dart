import 'package:flutter/material.dart';

import 'package:flutter_defualt_project/ui/home/home_screen.dart';
import 'package:flutter_defualt_project/ui/map/map_screen.dart';
import 'package:flutter_defualt_project/ui/splash/splash_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteNames {
  static const String homeScreen = "/homeScreen";
  static const String splashScreen = "/";
  static const String mapScreen = "/mapScreen";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RouteNames.mapScreen:
        return MaterialPageRoute(
          builder: (context) =>  MapScreen(latLong: settings.arguments as LatLng,),
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