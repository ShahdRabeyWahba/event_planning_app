import 'package:flutter/material.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle bold16White = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );
  static TextStyle bold16dark = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );
}
