import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AppTheme {
  AppTheme._();
  // Define your light theme here
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.black),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      brightness: Brightness.light,
      surface: AppColors.surfaceLight,
    ),
    cardColor: AppColors.surfaceLight,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.greyUnselected,
    ),
  );

  // Define your dark theme here
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.scaffoldDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.scaffoldDark,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.white),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      brightness: Brightness.dark,
      surface: AppColors.surfaceDark,
    ),
    cardColor: AppColors.surfaceDark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.scaffoldDark,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.greyUnselected,
    ),
  );
}
