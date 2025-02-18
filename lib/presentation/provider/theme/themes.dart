import 'package:doublevpartners/constants.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  primaryColor: COLOR_MAIN,
  cardTheme: CardTheme(elevation: 0.4),
  floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
    backgroundColor: COLOR_MAIN,
  ),
  checkboxTheme: CheckboxThemeData().copyWith(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return COLOR_MAIN;
      }
      return Colors.white;
    }),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Colors.white;
    }),
  ),
  switchTheme: SwitchThemeData().copyWith(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return COLOR_GREEN;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return COLOR_GREEN;
      }
      return Colors.white;
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return COLOR_GREEN;
      }
      return COLOR_GREEN;
    }),
  ),
  chipTheme: ChipThemeData(
    color: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return COLOR_MAIN;
      }
      return Colors.white; // Replace with your unselected color
    }),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    selectedColor: COLOR_MAIN,
    side: WidgetStateBorderSide.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return BorderSide(color: Colors.transparent, width: 0);
      } else {
        return BorderSide(color: Colors.grey, width: 0.8);
      }
    }),
  ),
  inputDecorationTheme: InputDecorationTheme().copyWith(
    filled: true,
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: COLOR_MAIN, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey),
    ),
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  primaryColor: COLOR_ORANGE,
  // scaffoldBackgroundColor: Colors.black,
  floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
    backgroundColor: COLOR_ORANGE,
  ),
  checkboxTheme: CheckboxThemeData().copyWith(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return COLOR_ORANGE;
      }
      return Colors.grey[800]!;
    }),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Colors.white;
    }),
  ),
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: Colors.grey[800],
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  switchTheme: SwitchThemeData().copyWith(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return COLOR_ORANGE;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return COLOR_ORANGE;
      }
      return Colors.grey[800]!;
    }),
  ),
  chipTheme: ChipThemeData(
    color: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return COLOR_ORANGE;
      }
      return Colors.grey[850]!;
    }),
    labelStyle: TextStyle(color: Colors.white),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    // selectedColor: COLOR_ORANGE,
  ),
  cardTheme: CardTheme(elevation: 0.4, color: Colors.grey[800]),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: COLOR_ORANGE,
    primary: COLOR_MAIN,
  ),
  inputDecorationTheme: InputDecorationTheme().copyWith(
    filled: true,
    fillColor: Colors.grey[850],
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey),
    ),
    labelStyle: TextStyle(color: Colors.white),
    errorMaxLines: 2,
    hintStyle: TextStyle(color: Color(0xFF767676)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: COLOR_ORANGE),
    ),
    focusColor: COLOR_ORANGE,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey),
    ),
  ),
);
