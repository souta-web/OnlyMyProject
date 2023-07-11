import 'package:flutter/material.dart';

class MyTheme extends ChangeNotifier {
  ThemeData current = ThemeData.light();
  bool _isDark = false;

  toggle() {
    _isDark = !_isDark;
    current = _isDark ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }
}


