import 'package:astrology_app/providers/theme_provider.dart';
import 'package:astrology_app/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<Themeprovider>(
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: "Poppins",
              backgroundColor: const Color(0xffd4d4d4),
              focusColor: const Color(0xff2e3149),
              primaryColor: const Color(0xff252a41),
              splashColor: Colors.indigoAccent),
          darkTheme: ThemeData(
              fontFamily: "Poppins",
              backgroundColor: const Color(0xff2e3149),
              focusColor: const Color(0xff2e3149),
              primaryColor: const Color(0xff252a41),
              splashColor: Colors.white),
          themeMode: (Provider.of<Themeprovider>(context).obj.isDark == false)
              ? ThemeMode.light
              : ThemeMode.dark,
          home: const AstroHomePage(),
        );
      },
      create: (context) => Themeprovider()));
}
