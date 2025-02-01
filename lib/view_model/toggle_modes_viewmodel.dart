import 'package:flutter/material.dart';
import '../constants/light_mode.dart';

class ToggleModes with ChangeNotifier {
  bool isCheck = false;
  ThemeData light = lightMode;

  void changeModes() {
    isCheck = !isCheck;
    notifyListeners();
  }

}