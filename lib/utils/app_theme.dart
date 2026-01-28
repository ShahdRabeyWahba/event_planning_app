
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.lightBlueColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.blackColor),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.lightBlueColor,
      unselectedItemColor: AppColors.blackColor,
      backgroundColor: AppColors.whiteColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightBlueColor,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.lightBlueColor,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackgroundColor,
      centerTitle: true,
      elevation: 0,
       iconTheme: IconThemeData(color: AppColors.whiteColor),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.lightBlueColor,
      unselectedItemColor: AppColors.whiteColor,
      backgroundColor: AppColors.darkBackgroundColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightBlueColor,
    ),
  );
}
