import 'package:flutter/material.dart';
import '../data/public_data.dart';

Color colorWAKGOOD = const Color(0xff01A45A);
Color colorWAKGOODLight = Color.lerp(colorWAKGOOD, Colors.white, 0.5)!;
Color colorINE = const Color(0xffB67FD4);
Color colorINELight = Color.lerp(colorINE, Colors.white, 0.5)!;
Color colorJINGBURGER = const Color(0xffFFEC62);
Color colorJINGBURGERLight = Color.lerp(colorJINGBURGER, Colors.white, 0.5)!;
Color colorLILPA = const Color(0xff203881);
Color colorLILPALight = Color.lerp(colorLILPA, Colors.white, 0.5)!;
Color colorJURURU = const Color(0xffEA447E);
Color colorJURURULight = Color.lerp(colorJURURU, Colors.white, 0.5)!;
Color colorGOSEGU = const Color(0xff8ACAFC);
Color colorGOSEGULight = Color.lerp(colorGOSEGU, Colors.white, 0.5)!;
Color colorVIICHAN = const Color(0xff99C555);
Color colorVIICHANLight = Color.lerp(colorVIICHAN, Colors.white, 0.5)!;
Color colorIfari = const Color(0xffC6FF01);
Color colorIfariLight = Color.lerp(colorIfari, Colors.white, 0.5)!;
Color colorISEGYEIDOL = const Color(0xffCE3669);
Color colorISEGYEIDOLLight = Color.lerp(colorISEGYEIDOL, Colors.white, 0.5)!;

List<Color> colorList = [
  colorWAKGOOD,
  colorIfari,
  colorINE,
  colorJINGBURGER,
  colorLILPA,
  colorJURURU,
  colorGOSEGU,
  colorVIICHAN,
];

Map<String, Color> streamerColorMap = {};
Map<String, Color> fanColorMap = Map.fromIterables(fanNameList, colorList);

void setStreamerColorMap() {
  List<Color> filteredColors = List.from(colorList)..removeAt(1);
  streamerColorMap = Map.fromIterables(channelIdList, filteredColors);
}
