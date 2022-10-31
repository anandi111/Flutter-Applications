import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sky_scrapper_1/models/theme.dart';

class ThemeProvider extends ChangeNotifier {
  AppTheme obj = AppTheme(isDark: true);

  void changeTheme() {
    obj.isDark = !obj.isDark;
    notifyListeners();
  }
}
