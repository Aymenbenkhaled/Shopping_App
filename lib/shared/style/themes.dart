import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ishopit/shared/style/colors.dart';

ThemeData LightTheme = ThemeData(
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    color: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.black),
    //backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      //systemNavigationBarColor: Colors.white
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    bodyMedium: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis),
  ),
);
ThemeData DarkTheme = ThemeData(
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    color: HexColor('333739'),
    elevation: 0,
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.white),
    //backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
      //systemNavigationBarColor: Colors.white
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      elevation: 20,
      backgroundColor: HexColor('333739'),
      unselectedItemColor: Colors.grey[400]),
  scaffoldBackgroundColor: HexColor('333739'),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis),
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
);
