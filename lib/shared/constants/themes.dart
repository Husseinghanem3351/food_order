import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_color_generator/material_color_generator.dart';

var lightTheme=ThemeData(
  brightness: Brightness.light,
  primaryColor: generateMaterialColor(color: HexColor('#d1cac4')),
  appBarTheme: AppBarTheme(
    color: generateMaterialColor(color: HexColor('#d1cac4'))
  ),
    inputDecorationTheme:  InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.grey[500],
      ),
      hintStyle:  TextStyle(
        color: Colors.grey[500],
        fontSize: 15
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.grey
        ),
      ),
      iconColor: Colors.black,
    ),
  iconTheme: const IconThemeData(
    color: Colors.black
  ),
  scaffoldBackgroundColor:Colors.white,
  primarySwatch: generateMaterialColor(color: HexColor('#d1cac4')),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 15,
    ),
    bodyMedium: TextStyle(
      fontSize: 18,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      color: Colors.black,
      fontSize: 22,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: Colors.black,
      fontSize: 17,
    ),
    titleLarge: TextStyle(
      fontSize: 24,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  ),

);

var darkTheme=ThemeData(
  brightness: Brightness.dark,
  iconTheme: const IconThemeData(
    color: Colors.black
  ),
  primaryColor: Colors.grey,
  appBarTheme: const AppBarTheme(
    color: Colors.grey
  ),
  inputDecorationTheme:  InputDecorationTheme(
    labelStyle: TextStyle(
      color: Colors.grey[300],
    ),
    hintStyle: TextStyle(
      color: Colors.grey[300],
    ),
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    enabledBorder:const OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
          color: Colors.grey
      ),
    ),
    iconColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.black12,
  primarySwatch: Colors.grey,
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 15,
    ),
    bodyMedium: TextStyle(
      fontSize: 18,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 22,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 17,
    ),
    titleLarge: TextStyle(
      fontSize: 24,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    ),

);