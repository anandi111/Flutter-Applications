import 'package:astrology_app/modals/theme.dart';
import 'package:flutter/material.dart';

class Themeprovider extends ChangeNotifier {
  AppTheme obj = AppTheme(isDark: true);

  changeTheme() {
    obj.isDark = !obj.isDark;
    notifyListeners();
  }
}
