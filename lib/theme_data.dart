import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData getThemeData() {
  return ThemeData(
    textTheme: TextTheme(
      headline4: TextStyle(fontSize: 48, fontWeight: FontWeight.w900),
      headline6: TextStyle(color: Colors.white),
      headline5: TextStyle(color: Colors.black, fontSize: 26),
      bodyText2: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(fontSize: 15, color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Color.fromRGBO(245, 247, 251, 1),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Color.fromRGBO(235, 235, 235, 1),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Color.fromRGBO(235, 235, 235, 1),
        ),
      ),
    ),
  );
}
