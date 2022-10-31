import 'package:color_pallet_app/modals/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  AppTheme obj = AppTheme(isDark: false);

  changeTheme() {
    obj.isDark = !obj.isDark;
    notifyListeners();
  }
}
