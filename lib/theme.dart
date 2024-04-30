import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_app/data/data.dart';

ThemeData walletAppTheme = ThemeData(
  useMaterial3: false,
  primaryColor: Colors.white,
  primaryColorLight: Colors.white,
  primaryColorDark: Colors.white,
  colorScheme: const ColorScheme.light(),
  fontFamily: GoogleFonts.mavenPro().fontFamily,
  textTheme: GoogleFonts.mavenProTextTheme(
    const TextTheme(
      displaySmall: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  buttonTheme: const ButtonThemeData(
    colorScheme: ColorScheme.light(
      primary: Colors.white,
    ),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: appBackgroundColor,
    surfaceTintColor: appBackgroundColor,
    titleTextStyle: TextStyle(
      color: Colors.white,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: appBackgroundColor,
    titleTextStyle: TextStyle(
      color: Colors.white,
    ),
    centerTitle: true,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  scaffoldBackgroundColor: appBackgroundColor,
  datePickerTheme: const DatePickerThemeData(
    todayBackgroundColor: MaterialStatePropertyAll(appBackgroundColor),
    confirmButtonStyle: ButtonStyle(
      foregroundColor: MaterialStatePropertyAll(appBackgroundColor),
    ),
    cancelButtonStyle: ButtonStyle(
      foregroundColor: MaterialStatePropertyAll(appBackgroundColor),
    ),
    rangePickerSurfaceTintColor: Colors.white,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  cardTheme: const CardTheme(
    surfaceTintColor: appBackgroundColor,
    color: appBackgroundColor,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    surfaceTintColor: appBackgroundColor,
    backgroundColor: appBackgroundColor,
    modalBackgroundColor: appBackgroundColor,
  ),
);
