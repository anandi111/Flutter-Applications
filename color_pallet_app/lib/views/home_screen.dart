import 'dart:math';
import 'package:color_pallet_app/providers/color_provider.dart';
import 'package:color_pallet_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ColorPalette extends StatefulWidget {
  const ColorPalette({Key? key}) : super(key: key);

  @override
  _ColorPaletteState createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Theme.of(context).backgroundColor,
            Theme.of(context).shadowColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ///Text...
              Text(
                "Color Palette\n Generator",
                style: GoogleFonts.cinzel(
                  textStyle: TextStyle(
                      color: Theme.of(context).focusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                textAlign: TextAlign.center,
              ),

              ///Color Palette....
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Column(
                  children: List.generate(
                    6,
                    (index) => Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                          color:
                              Provider.of<ColorProvider>(context).obj.colorList[
                                  Random().nextInt(
                                      Provider.of<ColorProvider>(context)
                                          .obj
                                          .colorList
                                          .length)],
                          borderRadius: BorderRadius.circular(0)),
                    ),
                  ),
                ),
              ),

              ///Generate Button..
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Provider.of<ColorProvider>(context, listen: false)
                              .changeColor();
                        },
                        child: Container(
                          height: 50,
                          width: 230,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).focusColor, width: 2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              "Generate",
                              style: GoogleFonts.cinzel(
                                  textStyle: TextStyle(
                                      color: Theme.of(context).focusColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {});
                          /*Provider.of<ThemeProvider>(context, listen: false)
                              .changeTheme();*/
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).focusColor, width: 2),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                              child: Icon(
                            Icons.light_mode_outlined,
                            color: Theme.of(context).focusColor,
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
