import 'package:flutter/foundation.dart';
import 'package:flutter_defualt_project/data/network/api_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/models/universal_data.dart';
import '../utils/constants.dart';

class AddressCallProvider with ChangeNotifier{
  AddressCallProvider({required this.apiService});

  final ApiService apiService;

  String scrolledAddressText = '';
  String kind = "house";
  int kindIndex = 0;
  String lang = "uz_UZ";
  MapType mapType=mapTypes.first;

  getAddressByLatLong({required LatLng latLng}) async {
    UniversalData universalData = await apiService.getAddress(
      latLng: latLng,
      kind: kind,
      lang: lang,
    );

    if (universalData.error.isEmpty) {
      scrolledAddressText = universalData.data as String;
    } else {
      debugPrint("ERROR:${universalData.error}");
    }
    notifyListeners();
  }

  void updateKind(String newKind) {
    kind = newKind;
  }

  void updateLang(String newLang) {
    lang = newLang;
  }

  bool canSaveAddress() {
    if (scrolledAddressText.isEmpty) return false;
    if (scrolledAddressText == 'Aniqlanmagan Hudud') return false;

    return true;
  }
}