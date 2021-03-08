import 'package:flutter/material.dart';
import 'const_values.dart';

class RoylenTheme {
  static ThemeData getThemeData() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: ConstValues.subduedColor.withOpacity(0.2),
        filled: true,
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: ConstValues.subduedColor.withOpacity(.8)),
          borderRadius: BorderRadius.circular(25),
          gapPadding: 8,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ConstValues.subduedColor.withOpacity(.8)),
          borderRadius: BorderRadius.circular(25),
          gapPadding: 8,
        ),
        labelStyle: TextStyle(
          color: ConstValues.appColor,
          fontFamily: 'Dosis',
          fontSize: 24,
        ),
        helperStyle: TextStyle(
          color: ConstValues.appColor.withOpacity(0.8),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: ConstValues.appColor,
        contentTextStyle: TextStyle(
            color: ConstValues.dialogTextColor,
            fontFamily: 'Dosis',
            fontSize: 16.0),
        titleTextStyle: TextStyle(
            color: ConstValues.dialogTextColor,
            fontFamily: 'QuickSand',
            fontSize: 28.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: ConstValues.subduedColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
      ),
      primaryColor: ConstValues.appColor,
      accentColor: ConstValues.accentColor,
      canvasColor: ConstValues.dialogTextColor,
      cardColor: ConstValues.dialogTextColor,
      hintColor: ConstValues.subduedColor,
      errorColor: ConstValues.errorColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: ConstValues.appColor,
          onPrimary: ConstValues.accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          minimumSize: Size(150, 50),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: ConstValues.appColor,
        ),
      ),
      primaryTextTheme: TextTheme(
        headline6: TextStyle(
            fontSize: 28.0,
            fontFamily: 'QuickSand',
            color: ConstValues.dialogTextColor),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 36.0,
          fontFamily: 'Quicksand',
          color: ConstValues.appColor,
        ),
        bodyText2: TextStyle(
          fontSize: 16.0,
          fontFamily: 'Dosis',
          color: ConstValues.appColor,
          height: 2.0,
        ),
        bodyText1: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Dosis',
            fontWeight: FontWeight.bold,
            color: ConstValues.appColor,
            height: 2.0),
      ),
    );
  }
}
