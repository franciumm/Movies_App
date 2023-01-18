import 'package:flutter/material.dart';
import 'package:movies/shared/styles/colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      primaryColor: PRIMARY_COLOR,
      backgroundColor: PRIMARY_COLOR,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: BtmNAVBck,
          unselectedItemColor: ItemsClr,
          elevation: 12,
          selectedItemColor: SEC_COLOR,
          selectedIconTheme: IconThemeData(size: 33),
          unselectedIconTheme: IconThemeData(size: 25),
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 9)),
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: PRIMARY_COLOR,
          onPrimary: GREY_COLOR,
          secondary: SEC_COLOR,
          onSecondary: BtmNAVBck,
          error: Colors.red,
          onError: Colors.white,
          background: PRIMARY_COLOR,
          onBackground: GREY_COLOR,
          surface: GREY_COLOR,
          onSurface: PRIMARY_COLOR),
      textTheme: TextTheme(
          headline1: TextStyle(
              color: ItemsClr, fontSize: 17, fontWeight: FontWeight.w400)));
}
