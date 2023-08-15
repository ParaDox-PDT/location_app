import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const baseUrl = "https://geocode-maps.yandex.ru";
const String apiKey = "78afe24c-066a-487f-bba4-af7a70bef19f";

class TimeOutConstants {
  static int connectTimeout = 30;
  static int receiveTimeout = 25;
  static int sendTimeout = 60;
}

const List<String> kindList = [
  "house",
  "metro",
  "district",
  "street",
];

const List<Icon> kindList2=[
  Icon(Icons.home),
  Icon(Icons.directions_subway),
  Icon(CupertinoIcons.location),
  Icon(Icons.line_axis),

];

const List<String> langList = [
  "uz_UZ",
  "ru_RU",
  "en_GB",
  "tr_TR",
];

const List<MapType> mapTypes = [
  MapType.hybrid,
  MapType.normal,
  MapType.satellite,
  MapType.terrain,
];