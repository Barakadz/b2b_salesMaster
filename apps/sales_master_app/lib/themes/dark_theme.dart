import 'package:flutter/material.dart';

final darkColorScheme = ColorScheme.dark(
    outlineVariant: Color(0xff222427),
    onSecondaryFixedVariant: Color(0x40E0E0E0),
    primary: Color(0xFFF02D4A), // Main accent color (buttons, links)
    //primary: Color(0xFF0f172a), // Main accent color (buttons, links)
    onPrimary: Color(0xffFFFFFF), // Text on primary
    secondary: Color(0xFFF02D4A), // Optional accent
    onSecondary: Color(0xFFFFFFFF),
    surface: Color(0xFF222427), // App background
    onSurface: Color(0xB3FFFFFF), // text on background
    onBackground: Color(0xff828282), // lighter text
    primaryContainer: Color(0x40EFF2F7),
    //surface: Colors.white, // Cards, sheets
    //onSurface: Color(0xFF333333), // Text on surface
    tertiaryContainer: Color(0X0DFFFFFF),
    error: Colors.red,
    onError: Colors.white,
    outline: Color(0X0DFFFFFF),
    surfaceVariant: Color(0xffEFF2F7),
    onSurfaceVariant: Color(0xFFFFFFFF), // label text color
    surfaceContainerHighest: Color(0xfffafcfe));

final darkTheme = ThemeData(
  dividerColor:
      Color(0xFFD2D2D2), // sidebare border and textfields borders notion
  //dividerColor: Color(0xFFCBD5E1), // sidebare border and textfields borders
  colorScheme: darkColorScheme,
  useMaterial3: true,
  scaffoldBackgroundColor: darkColorScheme.surface,
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
        color: Color(0xFFB2B4B9), // Hint text color
        //color: Color(0xFF94a3b8), // Hint text color
        fontSize: 16,
        fontWeight: FontWeight.w500),
    labelStyle: TextStyle(
        color: Color(0xFFB2B4B9), // Hint text color
        //color: Color(0xFF94a3b8), // Hint text color
        fontSize: 16,
        fontWeight: FontWeight.w500),
  ),
  iconTheme: IconThemeData(
      color: Color(0xFFB2B4B9), size: 24), //hint text and icons color notion
  //IconThemeData(color: Color(0xFF94a3b8)), //hint text and icons color
  textTheme: TextTheme(
    displayLarge: TextStyle(
        fontSize: 57, fontWeight: FontWeight.w600, color: Color(0xffFFFFFF)),
    displayMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: darkColorScheme.onSurfaceVariant),
    displaySmall: TextStyle(
        fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xffFFFFFF)),

    headlineLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xffFFFFFF)),
    headlineMedium: TextStyle(
        fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xffFFFFFF)),
    headlineSmall: TextStyle(
        fontSize: 24, fontWeight: FontWeight.w600, color: Color(0XffFFFFFF)),

    titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: darkColorScheme.onSurfaceVariant),
    titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: darkColorScheme.onSurfaceVariant), //Card titles
    titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: darkColorScheme.onSurfaceVariant),

    bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: darkColorScheme.onSurface),
    bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: darkColorScheme.onSurface),
    bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: darkColorScheme.onSurface),

    labelLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Color(0Xff828282)), // Buttons
    labelMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, color: Color(0Xff828282)),
    labelSmall: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: Color(0XFF828282)),
  ),
  // inputDecorationTheme: InputDecorationTheme(
  //   filled: true,
  //   fillColor: Colors.white,
  //   border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  // ),
);
