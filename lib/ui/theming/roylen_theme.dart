import 'package:flutter/material.dart';
import './custom_colors.dart';

class RoylenTheme {
  static ThemeData getThemeData() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
        color: CustomColors.appColor,
        fontFamily: 'Dosis',
        fontSize: 16,
      )),
      dialogTheme: DialogTheme(
          backgroundColor: CustomColors.appColor,
          contentTextStyle: TextStyle(
              color: CustomColors.dialogTextColor,
              fontFamily: 'Dosis',
              fontSize: 16.0),
          titleTextStyle: TextStyle(
              color: CustomColors.dialogTextColor,
              fontFamily: 'QuickSand',
              fontSize: 28.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      primaryColor: CustomColors.appColor,
      accentColor: CustomColors.accentColor,
      canvasColor: CustomColors.dialogTextColor,
      cardColor: CustomColors.dialogTextColor,
      hintColor: CustomColors.subduedColor,
      errorColor: CustomColors.errorColor,
      buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          buttonColor: CustomColors.appColor,
          textTheme: ButtonTextTheme.accent,
          colorScheme: ColorScheme.light(secondary: CustomColors.accentColor),
          minWidth: 100,
          height: 36),
      primaryTextTheme: TextTheme(
        headline6: TextStyle(
            fontSize: 28.0,
            fontFamily: 'QuickSand',
            color: CustomColors.dialogTextColor),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 36.0,
          fontFamily: 'Quicksand',
          color: CustomColors.appColor,
        ),
        bodyText2: TextStyle(
          fontSize: 16.0,
          fontFamily: 'Dosis',
          color: CustomColors.appColor,
          height: 2.0,
        ),
        bodyText1: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Dosis',
            fontWeight: FontWeight.bold,
            color: CustomColors.appColor,
            height: 2.0),
      ),
    );
  }
}
