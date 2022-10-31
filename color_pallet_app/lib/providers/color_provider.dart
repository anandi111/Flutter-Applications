import 'package:color_pallet_app/modals/color.dart';
import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier {
  ColorData obj = ColorData(colorList: [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purpleAccent,
    Colors.yellow,
    Colors.orange,
    Colors.teal,
    Colors.purple,
    Colors.deepPurple,
    Colors.black,
    Colors.white,
    Colors.tealAccent,
    Colors.lightGreen,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.deepPurpleAccent,
    Colors.purpleAccent,
    Colors.pink,
    Colors.pinkAccent,
  ]);

  changeColor() {
    notifyListeners();
  }
}
