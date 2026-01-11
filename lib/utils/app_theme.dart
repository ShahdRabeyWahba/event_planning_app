import 'package:event_planning_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBlueColor, // Better than transparent for testing
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.transparentColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: AppColors.whiteColor,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
  );

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: AppColors.blackColor,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
  );
}
