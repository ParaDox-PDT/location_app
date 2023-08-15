import 'package:flutter/foundation.dart';

class TabBoxProvider with ChangeNotifier{
  int  activeIndex=0;
  void   changeIndex(int index){
    activeIndex = index;
    notifyListeners();
  }
}